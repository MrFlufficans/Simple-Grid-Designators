// Perfectly Fine for Version 2.0.0


// _Target = PosATL
params ["_Target"];
_Target params ["_PosX","_PosY"];

// If we go Off Map we want to return a String full of 0's otherwise do the normal calculation
if (_PosX < 0 || _PosY < 0 || _PosX > worldSize || _PosY > worldSize) then {
	_PosX = "00000";
	_PosY = "00000";
} else {
	_PosX = str floor(_PosX/1);
	_PosY = str floor(_PosY/1);
	while {count _PosX < 10/2} do {_PosX = "0" + _PosX};
	while {count _PosY < 10/2} do {_PosY = "0" + _PosY};
};

// Return
_PosX + _PosY