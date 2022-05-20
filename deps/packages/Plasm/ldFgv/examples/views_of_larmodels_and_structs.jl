using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation

using Plasm
View = Plasm.view



square = ([[0; 0] [0; 1] [1; 0] [1; 1]], [[1, 2, 3, 4]], 
[[1,2], [1,3], [2,4], [3,4]])
V,FV,EV  =  square
model  =  V,([[1],[2],[3],[4]],EV,FV)
table = Lar.apply(Lar.t(-0.5,-0.5), square)
chair = Lar.Struct([Lar.t(0.75,0),Lar.s(0.35,0.35),table])
structo = Lar.Struct([Lar.t(2,1),table,repeat([Lar.r(pi/2),chair],outer = 4)...])
structo1 = Lar.Struct(repeat([structo,Lar.t(0,2.5)],outer = 10));
structo2 = Lar.Struct(repeat([structo1,Lar.t(3,0)],outer = 10));

scene = Lar.evalStruct(structo2);
View(scene)
W,FW,EW = Lar.struct2lar(structo2);
View(Plasm.lar2hpc(W,EW))
assembly = Lar.Struct([Lar.sphere()(), Lar.t(3,0,-1), Lar.cylinder()()])
View(assembly)
View(Lar.struct2lar(assembly))

cube = Lar.apply( Lar.t(-.5,-.5,0), Lar.cuboid([1,1,1]))
tableTop = Lar.Struct([ Lar.t(0,0,.85), Lar.s(1,1,.05), cube ])
tableLeg = Lar.Struct([ Lar.t(-.475,-.475,0), Lar.s(.1,.1,.89), cube ])
tablelegs = Lar.Struct( repeat([ tableLeg, Lar.r(0,0,pi/2) ],outer=4) )
table = Lar.Struct([ tableTop, tablelegs ])
table = Lar.struct2lar(table)
View(table)

cylndr = Lar.rod(.06, .5, 2*pi)([8,1])
chairTop = Lar.Struct([ Lar.t(0,0,0.5), Lar.s(0.5,0.5,0.04), cube ])
chairLeg = Lar.Struct([ Lar.t(-.22,-.22,0), Lar.s(.5,.5,1), Lar.r(0,0,pi/8), cylndr ])
chairlegs = Lar.Struct( repeat([ chairLeg, Lar.r(0,0,pi/2) ],outer=4) );
chair = Lar.Struct([ chairTop, chairlegs ]);
chair = Lar.struct2lar(chair)
View(chair)

theChair = Lar.Struct([ Lar.t(-.8,0,0), chair ])
fourChairs = Lar.Struct( repeat([Lar.r(0,0,pi/2), theChair],outer=4) );
fourSit = Lar.Struct([fourChairs,table]);
View(fourSit)
singleRow=Lar.Struct(repeat([fourSit,Lar.t(0,2.5,0)],outer=10));
View(singleRow)
refectory=Lar.Struct(repeat([singleRow,Lar.t(3,0,0)],outer=10));
View(refectory)
