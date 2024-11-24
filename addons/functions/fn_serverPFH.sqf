/*
 * Author: magicsh0tz
 *
 * Arguments:
 * 0: Arguments <ANY>
 * 1: Handle <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * None
 */

#include "script_component.hpp"

params ["_args","_pfhHandle"];

private ["_handles","_agentsToDelete","_currentTime"];

_handles = localNamespace getVariable [QVAR(handles),[]];
_agentsToDelete = localNamespace getVariable [QVAR(agentsToDelete),[]];

_currentTime = CURRENT_TIME;

{
    _x params ["_params","_startTime"];
    
    _params params ["_caller","_vehicle","_dummyDriver"];
    
    private ["_currentOwner","_dummyDriverOwner"];
    
    if (_startTime isEqualType 0) then {
        if ((driver _vehicle) == _dummyDriver) then {
            // Stop the check as it is already synced.
            _x set [1,true];
            
            #ifdef DEBUG_MODE
                player globalChat "Driver is in";
            #endif
        } else {
            // `driver _vehicle` may incorrectly return `objNull` as it takes some time to sync.
            if (_currentTime >= _startTime && {(_currentTime - _startTime) <= CONDITION_TIMEOUT}) then {
                #ifdef DEBUG_MODE
                    player globalChat "Waiting for driver to get in...";
                #endif
                
                continue;
            };
            
            #ifdef DEBUG_MODE
                player globalChat "Waiting for driver to get in condition timed out";
            #endif
        };
    };
    
    /*
        Removes the handle in the following scenarios:
        1. Vehicle destroyed.
        2. Dummy driver died. (This should not happen but check anyway)
        3. No controller, controller died, or controller becomes unconscious.
        4. Dummy driver not the driver of the vehicle. (Switch seat)
        5. Controller not gunner or commander. (Switch seat)
    */
    if (
        isNull _vehicle ||
        {!(alive _vehicle)} ||
        {isNull _dummyDriver} ||
        {!(alive _dummyDriver)} ||
        {isNull (_vehicle getVariable [QVAR(controller),objNull])} ||
        {(_vehicle getVariable [QVAR(dummyDriver),objNull]) != _dummyDriver} ||
        {(driver _vehicle) != _dummyDriver} ||
        {!(alive _caller)} ||
        {!([_caller,_vehicle] call FUNC(isGunnerOrCommander))} ||
        {_caller getVariable ["ACE_isUnconscious", false]} ||
        {(incapacitatedState _caller) isEqualTo "UNCONSCIOUS"}
    ) then {
        // Mark handle as `objNull` for cleanup.
        _handles set [_forEachIndex,objNull];
        
        if (!(isNull _dummyDriver)) then {
            _agentsToDelete pushBack [_dummyDriver,_currentTime];
        };
        
        if (!(isNull _vehicle)) then {
            _vehicle setVariable [QVAR(controller),nil,true];
            _vehicle setVariable [QVAR(dummyDriver),nil,true];
        };
        
        #ifdef DEBUG_MODE
            player globalChat "Handle removed";
        #endif
        
        continue;
    };
    
    _currentOwner = owner _caller;
    _dummyDriverOwner = owner _dummyDriver;
    if (_dummyDriverOwner != _currentOwner) then {
        // Set owner of dummyDriver to controller.
        _dummyDriver setOwner _currentOwner;
        
        #ifdef DEBUG_MODE
            player globalChat format ["Set dummyDriver owner to %1",_currentOwner];
        #endif
    };
} forEach _handles;
_handles = _handles - [objNull];
localNamespace setVariable [QVAR(handles),_handles];

{
    _x params ["_agent","_startTime",["_isMovingOut",false]];
    
    if (!(isAgent (teamMember _agent))) then {
        _agentsToDelete set [_forEachIndex,objNull];
        continue;
    };
    
    if (!_isMovingOut) then {
        moveOut _agent;
        _x set [2,true];
        
        #ifdef DEBUG_MODE
            player globalChat "Moving out driver";
        #endif
    };
    
    if (!(isNull (objectParent _agent)) && {_currentTime >= _startTime} && {(_currentTime - _startTime) <= CONDITION_TIMEOUT}) then {
        #ifdef DEBUG_MODE
            player globalChat "Waiting for driver to get out...";
        #endif
        
        continue;
    };
    
    _agentsToDelete set [_forEachIndex,objNull];
    
    #ifdef DEBUG_MODE
        if (isNull (objectParent _agent)) then {
            player globalChat "Driver got out";
        } else {
            player globalChat "Waiting for driver to get out condition timed out";
        };
    #endif
    
    deleteVehicle _agent;
} forEach _agentsToDelete;
_agentsToDelete = _agentsToDelete - [objNull];
localNamespace setVariable [QVAR(agentsToDelete),_agentsToDelete];
