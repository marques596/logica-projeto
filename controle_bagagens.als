module FlyingToHeaven

------------------------------------------------------------------------------------------------
--                    GRUPO 3
--                FRANCISCO IGOR
--                HIGOR SANTOS
--                MATEUS ALVES            
--                MAURICIO MARQUES
------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------
-->                  ASSINATURAS
-----------------------------------------------------------------------------------------------

abstract sig Passageiro{
	bagagens: set Bagagem,
	ticket: one Ticket
}
sig Comum,Milhagem,VIP extends Passageiro{}


abstract sig Bagagem{}
sig Leve,Mediana,Pesada extends Bagagem{}


abstract sig Ticket{}
sig Verde,Vermelho extends Ticket{}

------------------------------------------------------------------------------------------------
-->                  FUNÇÕES
-----------------------------------------------------------------------------------------------

fun getBagagensLeve [p: Passageiro] : set Bagagem {
	Leve & p.bagagens
}

fun getBagagensMedianas [p: Passageiro] : set Bagagem {
	Mediana & p.bagagens
}

fun getBagagensPesadas [p: Passageiro] : set Bagagem {
	Pesada & p.bagagens
}

------------------------------------------------------------------------------------------------
-->                  PREDICADOS
-----------------------------------------------------------------------------------------------

pred limiteComum [c:Comum]{
	no getBagagensMedianas[c] 
	lone getBagagensLeve[c] 
	lone getBagagensPesadas[c]
} 

pred limiteMilhagem [m:Milhagem]{
	lone getBagagensMedianas[m] 
	lone getBagagensLeve[m] 
	lone getBagagensPesadas[m]
}

pred limiteVIP [v:VIP]{
	# getBagagensMedianas[v] < 3 
	# getBagagensPesadas[v]  < 3 
	lone  getBagagensLeve[v]
}

pred passagemPermitida[p:Passageiro]{
		 p.ticket in Verde
}

pred passagemNegada[p:Passageiro]{
		p.ticket in Vermelho
}

------------------------------------------------------------------------------------------------
-->                  FATOS
-----------------------------------------------------------------------------------------------

fact Passageiros {
	all c:Comum | limiteComum[c] implies passagemPermitida[c] else passagemNegada[c]
	all m:Milhagem | limiteMilhagem[m] implies passagemPermitida[m] else passagemNegada[m]
	all v:VIP | limiteVIP[v] implies passagemPermitida[v] else passagemNegada[v]
}

fact Bagagens {
	all b:Bagagem | one (b.~bagagens)
}

fact Tickets {
	all t:Ticket| one (t.~ticket)
}

------------------------------------------------------------------------------------------------
-->                  ASSERTS
-----------------------------------------------------------------------------------------------

assert bagagensPassageiroComumValidos {
	all passageiro : Comum | passageiro.ticket = Verde implies
		(lone getBagagensLeve[passageiro] and 
		lone getBagagensPesadas[passageiro] and 
		no getBagagensMedianas[passageiro])
}

assert bagagensPassageiroComumInvalidos {
	all passageiro : Comum | passageiro.ticket = Vermelho implies
		(# getBagagensLeve[passageiro] > 1 or 
		# getBagagensPesadas[passageiro] > 1 or 
		# getBagagensMedianas[passageiro] > 0)
}

assert bagagensPassageiroMilhagemValidos {
	all passageiro : Milhagem | passageiro.ticket = Verde implies
		(lone getBagagensLeve[passageiro] and 
		lone getBagagensPesadas[passageiro] and 
		lone getBagagensMedianas[passageiro])
}

assert bagagensPassageiroMilhagemInvalidos {
	all passageiro : Milhagem | passageiro.ticket = Vermelho implies
		(# getBagagensLeve[passageiro] > 1 or 
		# getBagagensPesadas[passageiro] > 1 or 
		# getBagagensMedianas[passageiro] > 1)
}

assert bagagensPassageiroVIPValidos {
	all passageiro : VIP | passageiro.ticket = Verde implies
	(# getBagagensPesadas[passageiro] <= 2 and
	# getBagagensMedianas[passageiro] <= 2 and
	lone getBagagensLeve[passageiro])
}

assert bagagensPassageiroVIPInvalidos {
	all passageiro : VIP | passageiro.ticket = Vermelho implies
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
