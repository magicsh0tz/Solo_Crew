/*
 * Author: magicsh0tz
 * Checks if a unit can take controls.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Can take controls <BOOL>
 *
 * Example:
 * [_unit] call mgc_solo_crew_fnc_canTakeControls
 */

#include "script_component.hpp"

params ["_unit"];

private ["_vehicle","_controller","_dummyDriver"];

if (isNull _unit || {!(alive _unit)}) exitWith {
    false
};

_vehicle = objectParent _unit;
if (isNull _vehicle || {!(alive _vehicle)}) exitWith {
    false
};

_controller = _vehicle getVariable [QVAR(controller),objNull];
_dummyDriver = _vehicle getVariable [QVAR(dummyDriver),objNull];

({_vehicle isKindOf _x} count ALLOWED_TYPES) > 0 &&
{isNull (driver _vehicle)} &&
{isNull _controller} &&
{isNull _dummyDriver} &&
{!(lockedDriver _vehicle)} &&
{(locked _vehicle) <= 1} &&
{[_unit,_vehicle] call FUNC(isGunnerOrCommander)} &&
{!((fullCrew [_vehicle,"driver",true]) isEqualTo [])}
