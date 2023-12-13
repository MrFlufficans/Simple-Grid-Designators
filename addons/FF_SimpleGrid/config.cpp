#include "BIS_AddonInfo.hpp"
class CfgPatches {
  class FF_SimpleGrid {
    units[] = {};
    weapons[] = {};
    requiredVersion = 0.1;
    requiredAddons[] = {"A3_UI_F", "A3_Drones_F", "A3_Weapons_F", "A3_Weapons_F_beta", "cba_main"};
    version = 2.1;
  };
};

class CfgFunctions {
  class FF {
    class FF_SimpleGrid {
      file="\FF_SimpleGrid\functions";
      class SimpleGrid_gridInit {preInit=1};
      class SimpleGrid_postInit {postInit=1};
      class SimpleGrid_getGrid {};
      class SimpleGrid_markerScroll {};
      class SimpleGrid_placeMarker {};
      class SimpleGrid_relativeMarker {};
    };
  };
};

//#include "\FF_SimpleGrid\ui\defines.hpp"
#include "\FF_SimpleGrid\ui\baseClasses.hpp"

class RscTitles
{
	// Simple Grid
	#include "\FF_SimpleGrid\ui\simpleGridUI.hpp"	
};

class CfgMarkers {
  class Flag;
  class FF_SimpleGrid_Marker1: Flag {
    scope = 2;
    name = "Waypoint";
    icon = "\A3\ui_f\data\map\groupicons\waypoint.paa";
    texture = "\A3\ui_f\data\map\groupicons\waypoint.paa";
    color[] = {0, 0, 0, 1};
    shadow = 0;
    markerClass = "NATO_Respawn";
    side = 1;
    size = 32;
    showEditorMarkerColor = 1;
  };
  class FF_SimpleGrid_Marker2: FF_SimpleGrid_Marker1 {
    scope = 2;
    name = "Crosshair";
    icon = "\A3\ui_f\data\map\groupicons\selector_selectedMission_ca.paa";
    texture = "\A3\ui_f\data\map\groupicons\selector_selectedMission_ca.paa";
    color[] = {0, 0, 0, 1};
    shadow = 0;
    markerClass = "NATO_Respawn";
    side = 1;
    size = 32;
    showEditorMarkerColor = 1;
  };
  class FF_SimpleGrid_Marker3: FF_SimpleGrid_Marker1 {
    scope = 2;
    name = "Destroy";
    icon = "\A3\ui_f\data\map\markers\military\destroy_CA.paa";
    texture = "\A3\ui_f\data\map\markers\military\destroy_CA.paa";
    color[] = {0, 0, 0, 1};
    shadow = 0;
    markerClass = "NATO_Respawn";
    side = 1;
    size = 32;
    showEditorMarkerColor = 1;
  };
  class FF_SimpleGrid_Marker4: FF_SimpleGrid_Marker1 {
    scope = 2;
    name = "Dot";
    icon = "\A3\ui_f\data\map\markers\military\dot_CA.paa";
    texture = "\A3\ui_f\data\map\markers\military\dot_CA.paa";
    color[] = {0, 0, 0, 1};
    shadow = 0;
    markerClass = "NATO_Respawn";
    side = 1;
    size = 32;
    showEditorMarkerColor = 1;
  };
  class FF_SimpleGrid_Marker5: FF_SimpleGrid_Marker1 {
    scope = 2;
    name = "Marker";
    icon = "\A3\ui_f\data\map\markers\military\marker_CA.paa";
    texture = "\A3\ui_f\data\map\markers\military\marker_CA.paa";
    color[] = {0, 0, 0, 1};
    shadow = 0;
    markerClass = "NATO_Respawn";
    side = 1;
    size = 32;
    showEditorMarkerColor = 1;
  };
};

class CfgSounds {
  sounds[] = {};
  class FF_SimpleGrid_Designator1 {
    name = "Simple Grid Designator Mark Set";
    sound[] = {"\A3\Sounds_F_Bootcamp\SFX\VR\Simulation_Restart",3,1};
    titles[] = {};
  };
};