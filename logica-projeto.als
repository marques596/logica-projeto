module sistemaDeBagagens

enum Ticket {
	verde, vermelho
}

abstract sig Passageiro{
	bagagens: set Bagagem,
	ticket: one Ticket
}

sig PassageiroComum extends Passageiro{}
sig PassageiroMilhagem extends Passageiro{}
sig PassageiroVIP extends Passageiro{}

abstract sig Bagagem{}

sig BagagemLeve extends Bagagem{}
sig BagagemMediana extends Bagagem{}
sig BagagemPesada extends Bagagem{}

pred limitePassageiroComum [p:PassageiroComum]{
	no(BagagemMediana & p.bagagens) and
	lone (BagagemLeve & p.bagagens)  and
	lone (BagagemPesada & p.bagagens) 
} 

pred limitePassageiroMilhagem [p:PassageiroMilhagem]{
	lone(BagagemMediana & p.bagagens) and
	lone (BagagemLeve & p.bagagens)  and
	lone (BagagemPesada & p.bagagens) 
}

pred limitePassageiroVIP [p:PassageiroVIP]{
	# (BagagemMediana & p.bagagens) < 3 and
	# (BagagemPesada & p.bagagens)  < 3 and
	lone  (BagagemLeve & p.bagagens)
}

fact {
	all pc:PassageiroComum | limitePassageiroComum[pc] implies pc.ticket=verde else pc.ticket = vermelho
	all pm:PassageiroMilhagem | limitePassageiroMilhagem[pm] implies pm.ticket=verde else pm.ticket = vermelho
	all pv:PassageiroVIP | limitePassageiroVIP[pv] implies pv.ticket=verde else pv.ticket = vermelho
}

pred show[]{}
run show for 6
