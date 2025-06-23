name: test2fip_consistent
proc: {setObj left_obj.clampStrength 1 ; setObj right_obj.clampStrength 1; setObj left_obj_OUT.errorScale 1; setObj right_obj_OUT.errorScale 1}
I:
(left_obj)
1 1 0.75 0.75
(right_obj)
0.25 0 0.25 0
(left_name)
0 1 0
(right_name)
0 1 0 
T:
(left_obj_OUT)
1 1 0.75 0.75
(right_obj_OUT)
0.25 0 0.25 0
(left_name_OUT)
0 1 0
(right_name_OUT)
0 1 0 
;
name: test2fip_inconsistent
proc: {setObj left_obj.clampStrength 1 ; setObj right_obj.clampStrength 1; setObj left_obj_OUT.errorScale 1; setObj right_obj_OUT.errorScale 1}
I:
(left_obj)
1 1 0.75 0.75
(right_obj)
0.75 1 0.75 1
(left_name)
0 1 0 
(right_name)
1 0 0
T:
(left_obj_OUT)
1 1 0.75 0.75
(right_obj_OUT)
0.75 1 0.75 1
(left_name_OUT)
0 1 0 
(right_name_OUT)
1 0 0
;