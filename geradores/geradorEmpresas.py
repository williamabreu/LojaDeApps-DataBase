from random import randint as rnd

nomesEmpresas = [
	'Pcenter Informática',
	'Contron',
	'Datacel',
	'Extra Bits',
	'Magasyn',
	'Tuttistore',
	'Francomp',
	'Center Tech',
	'CompuShop',
	'InfoTech',
	'Google',
	'Microsoft',
	'Apple Inc.',
	'Compjunior',
	'EMakers'
]

nomesRuas = [
	'Via Sérgio Braga',
	'Avenida Belmonte',
	'Avenida Presidente Kennedy',
	'Rua General Oswaldo Pinto da Veiga',
	'Rua Lúcio Bittencourt',
	'Rua Alberto Pasqualine',
	'Avenida dos Trabalhadores',
	'Avenida Lucas Evangelista',
	'Avenida Paulo de Frontin',
	'Avenida Sete de Setembro',
	'Avenida Nestor Perlingeiro',
	'Avenida Amaral Peixoto',
	'Avenida Getúlio Vargas',
	'Rua Gustavo Lira',
	'Rua São João',
	'Avenida Santa Edwiges',
	'Rua Capitão Benedito Lopes Bragança',
	'Rodovia dos Metalúrgicos',
	'Estrada da Companhia',
	'Estrada Francisco Vilela Arantes'
]

nomesCidades = [
	'Perdões',
	'Lavras',
	'Campo Belo',
	'Varginha',
	'Belo Horizonte',
	'São Paulo',
	'Curitiba'
]

nomesPaises = [
	'Brasil',
	'França',
	'Austrália'
]

nomesBairros = [
	'Centro',
	'Zona Leste',
	'Zona Norte',
	'Zona Sul'
]

def gerarCnpj():
	return '{}.{}.{}-{}'.format(rnd(10,99), rnd(100,999), rnd(1000,9999), rnd(10,99))

def gerarLogradouro():
	return nomesRuas[rnd(0, len(nomesRuas)-1)]

def gerarNumero():
	if rnd(1,100) % 5 == 0:
		return 'NULL'
	else:
		return rnd(1, 1855)

def gerarBairro():
	if rnd(1,100) % 5 == 0:
		return 'NULL'
	else:
		return "'" + nomesBairros[rnd(0, len(nomesBairros)-1)] + "'"

def gerarSite(nome):
	if rnd(1,100) % 5 == 0:
		return 'NULL'
	else:
		return "'" + nome.split()[0].lower() + '.com.br' + "'"

def gerarCidade():
	return nomesCidades[rnd(0, len(nomesCidades)-1)]

def gerarPais():
	return nomesPaises[rnd(0, len(nomesPaises)-1)]

if __name__ == '__main__':
	for nome in nomesEmpresas:
		print("call insertEmpresa('{0}', '{1}', 'senha-{0}', '{2}', '{3}', {4}, {5}, '{6}', '{7}', {8});".format(
				nome.split()[0].lower(), gerarCnpj(), nome, gerarLogradouro(), gerarNumero(), gerarBairro(), 
				gerarCidade(), gerarPais(), gerarSite(nome)
			)
		)
