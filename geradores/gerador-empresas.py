from random import randint as rnd

lista = [
	
]

def gerarCnpj():
	return '{}.{}.{}-{}'.format(rnd(10,99), rnd(100,999), rnd(1000,9999), rnd(10,99))

def gerarLogaradouro():
	return

for nome in lista:
	print("insertEmpresa('{0}', '{1}', 'senha-{0}', '{2}', '{3}', '{4}', '{5}', '{6}', '{7}', '{0}.com.br')".format(
			nome.split()[0].lower(), gerarCnpj(), nome, gerarLogradouro(), rnd(1,5000), bairro, cidade, pais
		)
	)
