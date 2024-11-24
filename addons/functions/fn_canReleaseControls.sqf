/*
 * Author: magicsh0tz
 * Checks if a unit can release controls.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Can release controls <BOOL>
 *
 * Example:
 * [_unit] call mgc_solo_crew_fnc_canReleaseControls
 */

#include "script_component.hpp"

params ["_unit"];

private ["_vehicle","_controller"];

if (isNull _unit || {!(alive _unit)}) exitWith {
    false
};

_vehicle = objectParent _unit;
if (isNull _vehicle || {!(alive _vehicle)}) exitWith {
    false
};

_controller = _vehicle getVariable [QVAR(controller),objNull];

_controller == _unit
