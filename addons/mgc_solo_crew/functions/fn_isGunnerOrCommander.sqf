/*
 * Author: magicsh0tz
 * Checks if a unit is a gunner or commander of a specific vehicle.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Vehicle <OBJECT>
 *
 * Return Value:
 * Unit is gunner or commander of the vehicle <BOOL>
 *
 * Example:
 * [_vehicle,_unit] call mgc_solo_crew_fnc_isGunnerOrCommander
 */

#include "script_component.hpp"

params ["_unit","_vehicle"];

private ["_gunnerInfo","_commanderInfo"];

if (isNull _unit || {isNull _vehicle}) exitWith {
    false
};

_gunnerInfo = fullCrew [_vehicle,"gunner"];
_commanderInfo = fullCrew [_vehicle,"commander"];

(!(_gunnerInfo isEqualTo []) && {((_gunnerInfo select 0) select 0) == _unit}) || 
{(!(_commanderInfo isEqualTo []) && {((_commanderInfo select 0) select 0) == _unit})}
