module FlyingToHeaven

------------------------------------------------------------------------------------------------
--                    GRUPO 3
--                 FRANCISCO IGOR
--                  HIGOR SANTOS
--                  MATEUS ALVES            
--                MAURICIO MARQUES
------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------
-->                  ENUMERAÇÃO
-----------------------------------------------------------------------------------------------

enum Ticket {
	verde, vermelho
}

------------------------------------------------------------------------------------------------
-->                  ASSINATURAS
-----------------------------------------------------------------------------------------------

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


------------------------------------------------------------------------------------------------
-->                  FUNÇÕES
-----------------------------------------------------------------------------------------------

fun getBagagensLeve [p: Passageiro] : set Bagagem {
	BagagemLeve & p.bagagens
}

fun getBagagensMedianas [p: Passageiro] : set Bagagem {
	BagagemMediana & p.bagagens
}

fun getBagagensPesadas [p: Passageiro] : set Bagagem {
	BagagemPesada & p.bagagens
}

------------------------------------------------------------------------------------------------
-->                  PREDICADOS
-----------------------------------------------------------------------------------------------

pred limitePassageiroComum [p:PassageiroComum]{
	no getBagagensMedianas[p] and
	lone getBagagensLeve[p] and
	lone getBagagensPesadas[p]
} 

pred limitePassageiroMilhagem [p:PassageiroMilhagem]{
	lone getBagagensMedianas[p] and
	lone getBagagensLeve[p]  and
	lone getBagagensPesadas[p]
}

pred limitePassageiroVIP [p:PassageiroVIP]{
	# getBagagensMedianas[p] < 3 and
	# getBagagensPesadas[p]  < 3 and
	lone  getBagagensLeve[p]
}

------------------------------------------------------------------------------------------------
-->                  FATOS
-----------------------------------------------------------------------------------------------

fact Passageiros {
	all pc:PassageiroComum | limitePassageiroComum[pc] implies pc.ticket=verde else pc.ticket = vermelho
	all pm:PassageiroMilhagem | limitePassageiroMilhagem[pm] implies pm.ticket=verde else pm.ticket = vermelho
	all pv:PassageiroVIP | limitePassageiroVIP[pv] implies pv.ticket=verde else pv.ticket = vermelho
}

fact Bagagens {
	all b:Bagagem | one (b.~bagagens)
}

fact Tickets {
	all t:Ticket| one t.~ticket
}

------------------------------------------------------------------------------------------------
-->                  ASSERTS
-----------------------------------------------------------------------------------------------

assert bagagensPassageiroComumValidos {
	all passageiro : PassageiroComum | passageiro.ticket = verde implies
		(lone getBagagensLeve[passageiro] and 
		lone getBagagensPesadas[passageiro] and 
		no getBagagensMedianas[passageiro])
}

assert bagagensPassageiroComumInvalidos {
	all passageiro : PassageiroComum | passageiro.ticket = vermelho implies
		(# getBagagensLeve[passageiro] > 1 or 
		# getBagagensPesadas[passageiro] > 1 or 
		# getBagagensMedianas[passageiro] > 0)
}

assert bagagensPassageiroMilhagemValidos {
	all passageiro : PassageiroMilhagem | passageiro.ticket = verde implies
		(lone getBagagensLeve[passageiro] and 
		lone getBagagensPesadas[passageiro] and 
		lone getBagagensMedianas[passageiro])
}

assert bagagensPassageiroMilhagemInvalidos {
	all passageiro : PassageiroMilhagem | passageiro.ticket = vermelho implies
		(# getBagagensLeve[passageiro] > 1 or 
		# getBagagensPesadas[passageiro] > 1 or 
		# getBagagensMedianas[passageiro] > 1)
}

assert bagagensPassageiroVIPValidos {
	all passageiro : PassageiroVIP | passageiro.ticket = verde implies
	(# getBagagensPesadas[passageiro] <= 2 and
	# getBagagensMedianas[passageiro] <= 2 and
	lone getBagagensLeve[passageiro])
}

assert bagagensPassageiroVIPInvalidos {
	all passageiro : PassageiroVIP | passageiro.ticket = vermelho implies
	(# getBagagensPesadas[passageiro] > 2 or
	# getBagagensMedianas[passageiro] > 2 or
	# getBagagensLeve[passageiro] > 1)
}

check bagagensPassageiroComumValidos for 10
check bagagensPassageiroComumInvalidos for 10
check bagagensPassageiroMilhagemValidos for 10
check bagagensPassageiroMilhagemInvalidos for 10
check bagagensPassageiroVIPValidos for 10
check bagagensPassageiroVIPInvalidos for 10

pred show[]{}
run show for 8
