class RscObject;
class RscText;
class RscFrame;
class RscLine;
class RscProgress;
class RscPicture;
class RscPictureKeepAspect;
class RscVideo;
class RscHTML;
class RscButton;
class RscShortcutButton;
class RscEdit;
class RscCombo;
class RscListBox;
class RscListNBox;
class RscXListBox;
class RscTree;
class RscSlider;
class RscXSliderH;
class RscActiveText;
class RscActivePicture;
class RscActivePictureKeepAspect;
class RscStructuredText;
class RscToolbox;
class RscControlsGroup;
class RscControlsGroupNoScrollbars;
class RscControlsGroupNoHScrollbars;
class RscControlsGroupNoVScrollbars;
class RscButtonTextOnly;
class RscButtonMenu;
class RscButtonMenuOK;
class RscButtonMenuCancel;
class RscButtonMenuSteam;
class RscMapControl;
class RscMapControlEmpty;
class RscCheckBox;

#define GUI_GRID_X_SimpleGrid ((safeZoneX + (safeZoneW - ((safeZoneW / safeZoneH) min 1.2)) / 2))
#define GUI_GRID_Y_SimpleGrid ((safeZoneY + (safeZoneH - (((safeZoneW / safeZoneH) min 1.2) / 1.2)) / 2))
#define GUI_GRID_W_SimpleGrid ((((safeZoneW / safeZoneH) min 1.2) / 40))
#define GUI_GRID_H_SimpleGrid (((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25))
#define GUI_GRID_WAbs_SimpleGrid (((safeZoneW / safeZoneH) min 1.2))
#define GUI_GRID_HAbs_SimpleGrid ((((safeZoneW / safeZoneH) min 1.2) / 1.2))