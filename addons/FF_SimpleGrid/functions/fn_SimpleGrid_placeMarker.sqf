// Reworked for Version 2.0.0

// Check for Interface
if (!hasInterface) exitWith {};

// If Designators are Disabled exit Early
if (FF_SimpleGrid_DisableDesignators) exitWith {};

// If the Laser doesn't have a proper Position Exit Early
if (FF_SimpleGrid_laserPos isEqualTo [0,0,0]) exitWith {};

// _mode is 1 or 2, With Info and Without Respectively
params ["_mode"];

// Defining Variables
_targetPos = [];
_gridX = "";
_gridY = "";

// Actual Thing
_doThing = {
	
	// _targetPos is position of Marker Placement
	// _printStamp is a Boolean whether to include information on the mark like Timestamp
	params ["_targetPos", "_printStamp"];

	// Grab Current Time
	_hour =	date select 3;
	_minute = date select 4;

	// If the Numbers are less than 10 add a 0 in front so 12:2 becomes 12:02 correctly
	if (_hour < 10) then {_hour = format ["%1%2", "0", _hour]};
	if (_minute < 10) then {_minute = format ["%1%2", "0", _minute]};

	// Get Current Grid Coordinates
	_grid = [_targetPos] call FF_fnc_SimpleGrid_getGrid;
	
	// Add the Coordinates together with a Dash separating the X and Y
	
	switch (FF_SimpleGrid_MarkerDefinition) do {
		case 8: {
			_grid = format ["%1-%2", _grid select [0, 4], _grid select [5, 4]]
		};
		case 10: {
			_grid = format ["%1-%2", _grid select [0, 5], _grid select [5, 5]]
		};
		default { };
	};

	// Creating the Marker
	// It needs a unique Name alongside the _USER_DEFINED_ which allows it to be editable by players
	_uniqueName = random [0, 10, 20];
	_stampUnique = format ["%1%2", "_USER_DEFINED_", _uniqueName];
	_marker = createMarkerLocal [_stampUnique, _targetPos, currentChannel, player];
	_marker setMarkerTypeLocal FF_SimpleGrid_markerType;
	_marker setMarkerShapeLocal "ICON";
	
	// If we are adding Information
	if _printStamp then {
		_stamp = _grid;
		_asl = str round(FF_SimpleGrid_laserPos select 2);
		_time = format ["%1:%2", _hour, _minute];

		// If the Timestamp has been disabled in the players Settings we Ommit it
		if !FF_SimpleGrid_NoMarkerTime then {_stamp = format ["%1 %2", _time, _stamp]};

		if !FF_SimpleGrid_NoASL then {_stamp = format ["%1 ATL:%2", _stamp, _asl]};
		
		_marker setMarkerTextLocal _stamp;
	} else {
		_marker setMarkerTextLocal "";
	};

	// Set Colour last to broadcast Over Network all at once to Save Network Performance
	_marker setMarkerColor FF_SimpleGrid_markerColour;
	"FF_SimpleGrid_Set" cutRsc ["FF_SimpleGrid_Set", "PLAIN", -1, false];
	playSoundUI ["FF_SimpleGrid_Designator1", 0.5];
};

switch (_mode) do 
{
	case 0: {
		[FF_SimpleGrid_laserPos, true] call _doThing
	};

	case 1: {
		[FF_SimpleGrid_laserPos, false] call _doThing
	};
	default {};
};