#define NAME mgc_solo_crew

#define QUOTE(var1) #var1
#define FUNC(var1) ##NAME##_fnc_##var1
#define QFUNC(var1) QUOTE(FUNC(var1))
#define VAR(var1) ##NAME##_##var1
#define QVAR(var1) QUOTE(VAR(var1))
