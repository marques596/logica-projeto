abstract sig Passageiro{
	bagagens: set Bagagem
}


sig PassageiroComum extends Passageiro{}
sig PassageiroMilhagem extends Passageiro{}
sig PassageiroVIP extends Passageiro{}


abstract sig Bagagem{}

sig BagagemLeve extends Bagagem{}
sig BagagemMediana extends Bagagem{}
sig BagagemPesada extends Bagagem{}





pred limitePassageiroComum[p:PassageiroComum]{
	no(BagagemMediana & p.bagagens) and
	lone (BagagemLeve & p.bagagens)  and
	lone (BagagemPesada & p.bagagens) 
} 

pred limitePassageiroMilhagem[p:PassageiroMilhagem]{
	lone(BagagemMediana & p.bagagens) and
	lone (BagagemLeve & p.bagagens)  and
	lone (BagagemPesada & p.bagagens) 

}

pred limitePassageiroVIP[p:PassageiroVIP]{
	# (BagagemMediana & p.bagagens) < 3 and
	# (BagagemPesada & p.bagagens)  < 3 and
	lone  (BagagemLeve & p.bagagens)

}


fact{
	all pc:PassageiroComum | limitePassageiroComum[pc]
	all pm:PassageiroMilhagem | limitePassageiroMilhagem[pm]
	all pv:PassageiroVIP | limitePassageiroVIP[pv]

}


pred show[]{}
run show for 6
