abstract sig Passageiro{
	bagagens: set Bagagem
}


sig PassageiroComum extends Passageiro{}
--sig PassageiroMilhagem extends Passageiro{}
--sig PassageiroVIP extends Passageiro{}


abstract sig Bagagem{}

sig BagagemLeve extends Bagagem{}
sig BagagemMediana extends Bagagem{}
sig BagagemPesada extends Bagagem{}





pred limitePassageiroComum[p:PassageiroComum]{
	#(BagagemMediana & p.bagagens)=0 and
	lone (BagagemLeve & p.bagagens)  and
	lone (BagagemPesada & p.bagagens) 




} 

fact{
	all p:PassageiroComum | limitePassageiroComum[p]



}


pred show[]{}
run show for 6
