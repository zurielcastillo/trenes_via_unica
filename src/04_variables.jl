using JuMP
using HiGHS



function variables_1!(model,N,Q)

    A = @variable(model, [i in N, q in Q], lower_bound = 0)

    D = @variable(model, [i in N, q in Q], lower_bound = 0)

    o = @variable(model, [i in N, q in Q], Bin)

    retraso = @variable(model, [i in N], lower_bound = 0)
    
    d = @variable(model,[p in P], lower_bound = 0)

    return A,D,o,retraso,d

end


function variables_2!(model,ZSet,Omega,ThetaSet)

    z = @variable(model,[(q,c) in ZSet],Bin)

    x = @variable(model,[omega in Omega],Bin)

    theta = @variable(model,[idx in ThetaSet],Bin)

    return z,x,theta

end
