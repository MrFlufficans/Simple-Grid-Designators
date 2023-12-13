// If we disable Designators we exit early
if (FF_SimpleGrid_DisableDesignators) exitWith {};

// If we don't have a Laser we exit early
if !FF_SimpleGrid_InUI exitWith {};

// Whether to Scroll Marker Type or Marker Colour
params ["_scroll"];

_markerTypes = [];
_markerNames = ["Waypoint","Crosshair","Destroy","Dot","Marker"];
_colourTypes = ["ColorBlack","ColorRed","ColorYellow","ColorGreen","ColorBlue"];
_colourName = ["Black","Red","Yellow","Green","Blue"];
_markerTypes = ["hd_pickup","hd_objective","hd_destroy","hd_dot","hd_warning"];

if (FF_SimpleGrid_CreationType == "Modded") then {
	_markerTypes = ["FF_SimpleGrid_Marker1","FF_SimpleGrid_Marker2","FF_SimpleGrid_Marker3","FF_SimpleGrid_Marker4","FF_SimpleGrid_Marker5"]
};

switch (_scroll) do {
	// We are scrolling Marker Type
	case 0: {
		_NewMarkerType = (_markerTypes find FF_SimpleGrid_MarkerType);
		if (_NewMarkerType == 4) then {_NewMarkerType = 0} else {_NewMarkerType = _NewMarkerType + 1};
		//FF_SimpleGrid_MarkerPath = _MarkerPaths select _NewMarkerType; Legacy Code? I don't know why this is here
		//Nevermind I remembered, it was my attempt to store the directory path of the Marker Icon
		playsoundUI ["Topic_Trigger", 0.2];
		call {
			FF_SimpleGrid_MarkerType = _markerTypes select _NewMarkerType;
			FF_SimpleGrid_MarkerName = _markerNames select _NewMarkerType;
		};

	};
	case 1: {
		_NewMarkerColour = (_colourTypes find FF_SimpleGrid_MarkerColour);
		if (_NewMarkerColour == 4) then {_NewMarkerColour = 0} else {_NewMarkerColour = _NewMarkerColour + 1};
		playsoundUI ["Topic_Trigger", 0.2];
		call {
			FF_SimpleGrid_MarkerColour = _colourTypes select _NewMarkerColour;
			FF_SimpleGrid_MarkerColourName = _colourName select _NewMarkerColour;
		};
	
	};
	default { };
};