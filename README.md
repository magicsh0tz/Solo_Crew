# Solo_Crew
Solo_Crew redefines armored vehicle gameplay in Arma 3, enabling gunners or commanders take control of their tanks and APCs without needing a dedicated driver. Inspired by War Thunder, this mod allows you to operate vehicles as a one-man crew, enhancing flexibility for solo operators.

This mod is must be installed on the server and is optional for clients. Clients that do not have the mod installed will not be able to "Take controls".

It is recommended to run [CBA_A3](https://steamcommunity.com/workshop/filedetails/?id=450814997) to optimize the performance of Per Frame Handlers (PFHs).

Submit issues and feature requests [here](https://github.com/magicsh0tz/Solo_Crew/issues).

## Usage
1. Enter a Tank/APC as the gunner or commander.
2. Select "Take controls" in the action menu (scroll wheel) to take control of the vehicle.
3. Control the vehicle using WASD keys. (Select "Release controls" to release the controls)

## Remote Execution Whitelist (if applicable)
```
class CfgRemoteExec
{
    class Functions
    {
        ...
        class mgc_solo_crew_fnc_takeControls { allowedTargets = 2; jip = 0; };
    };
};
```
