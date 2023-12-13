// Reworked for Version 2.0.0

["FF_SimpleGrid_DisableDesignators", "CHECKBOX", ["Disable Designator Grid Calculation", "While Ticked Laser Designators will Not Show Grid Coordinates"], "Simple Grid Designators", false,0,{},false] call CBA_fnc_addSetting;
["FF_SimpleGrid_NoMarkerTime", "CHECKBOX", ["Remove Time Stamp from Markers", "While Ticked Markers will not be placed with Time Stamps"], "Simple Grid Designators", false,0,{},false] call CBA_fnc_addSetting;
["FF_SimpleGrid_NoASL", "CHECKBOX", ["Remove ASL from Markers", "While Ticked Markers will not be placed with ASL"], "Simple Grid Designators", false,0,{},false] call CBA_fnc_addSetting;
["FF_SimpleGrid_MarkerDefinition", "LIST", ["Grid Definition for Markers", "8 or 10 Digit Markers"], "Simple Grid Designators", [[8, 10], ["8 Digit","10 Digit"], 1]] call CBA_fnc_addSetting;
["FF_SimpleGrid_CreationType", "LIST", ["Marker Class", "Vanilla means people without the Mod will see them"], "Simple Grid Designators", [["Modded", "Vanilla"], ["Modded","Vanilla"], 1]] call CBA_fnc_addSetting;
["FF_SimpleGrid_laserBatteryProxies", "EDITBOX", ["Laser Battery Magazines", "Certain Mods add their own Laser Battery Magazine, If the mod doesn't work you may need to manually add them"], "Simple Grid Designators", ["Laserbatteries, rhs_LaserMag_ai"], true] call CBA_fnc_addSetting;

["Simple Grid Designators", "FF_SimpleGrid_PlaceMarkerFromDes1", "Place Marker From Laser Designator", {[0] call FF_fnc_SimpleGrid_placeMarker},""] call CBA_fnc_addKeybind;
["Simple Grid Designators", "FF_SimpleGrid_PlaceMarkerFromDes2", "Place Marker From Laser Designator without Extra Info", {[1] call FF_fnc_SimpleGrid_placeMarker},""] call CBA_fnc_addKeybind;
["Simple Grid Designators", "FF_SimpleGrid_RelativeMarker", "Relative Distance and Bearing from One Point to Another", {call FF_fnc_SimpleGrid_relativeMarker},""] call CBA_fnc_addKeybind;
["Simple Grid Designators", "FF_SimpleGrid_MarkerScroll1", "Scroll Through Marker Types", {[0] call FF_fnc_SimpleGrid_markerScroll},""] call CBA_fnc_addKeybind;
["Simple Grid Designators", "FF_SimpleGrid_MarkerScroll2", "Scroll Through Marker Colour", {[1] call FF_fnc_SimpleGrid_markerScroll},""] call CBA_fnc_addKeybind;
