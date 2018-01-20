import random

lista = [
    'Alexandre Frota',
    'Joaquim Grandíssimo',
    'Ricardo Planeta',
    'Zambaldina Júdice',
    'Gerson Hernandes',
    'Cristiano Ribas',
    'Fabíola Harém',
    'Virgínia Póvoas',
    'Valério Colares',
    'Damião Frade',
    'Olavo Docarvalho',
    'Ágata Ribas',
    'Solano Amado',
    'Henriqueta Ribeiro',
    'Catarino Coelho',
    'Arminda Simão',
    'Nicolau Barroso',
    'Débora Ferro',
    'Amanda Nuds',
    'Aleixo Velasques'
]


def gerarDinheiro():
	return random.randint(0, 1500) + random.randint(0,99) / 100

def gerarTipoConta():
	x = random.randint(0,2)
	if x == 0:
		return 'individual'
	elif x == 1:
		return 'familiar'
	else:
		return 'estudante'
	
def gerarAno():
	return random.randint(1938, 2009)

def gerarMes():
	return random.randint(1,12)

def gerarDia():
	return random.randint(1,28)

for nome in lista:
	print( "call insertUsuario('{0}', '{0}@ufla.br', 'senha-{0}', '{1}', '{2}', {3}, '{4}-{5:02d}-{6:02d}');".format(
			nome.split()[0].lower(), nome, gerarTipoConta(), gerarDinheiro(), gerarAno(), gerarMes(), gerarDia()
		)
	)
