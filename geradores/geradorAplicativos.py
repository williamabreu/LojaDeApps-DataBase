from geradorEmpresas import nomesEmpresas as nomes
from random import randint as rnd


apps = [
	('Facebook', 'redeSocial', 12),
	('WhatsApp', 'mensagem', 10),
	('Tinder', 'namoro', 18),
	('Internet Explorer', 'internet', 'NULL'),
	('Safari', 'internet', 'NULL' ),
	('Docs Explorer', 'arquivos', 'NULL'),
	('Design Circuit', 'ciencia', 'NULL'),
	('Discord', 'mensagem', 14),
	('SIG estudante', 'educa', 'NULL'),
	('Governo Federal APP', 'politica', 'NULL'),
	('Socratic', 'educação', 16),
	('Airbnb', 'vendas', 18),
	('CastBox', 'NULL', 12),
	('Medite.se', 'conforto', 'NULL'),
	('Sons Relaxantes', 'conforto', 'NULL'),
	('Melhores crianças', 'NULL', 'NULL'),
	('Star Walk 2', 'jogo', 10),
	('Mondly', 'NULL', 'NULL'),
	('Cidade Sago Mini', 'jogo', 10),
	('A Vida na Toca', 'educação', 'NULL'),
	('Dr. Panda Café', 'educação', 'NULL'),
	('Messenger Lite', 'mensagens', 12),
	('Photo Editor', 'imagem', 'NULL'),
	('Kwai', 'NULL', 14),
	('MagiMobile', 'imagem', 'NULL'),
	('Selfie Camera', 'imagem', 12),
	('Notebook', 'texto', 'NULL'),
	('Journey', 'notícia', 12),
	('Today Weather', 'notícia', 10)
]

def getEmpresaLogin():
	return nomes[rnd(0, len(nomes)-1)].split()[0].lower()


if __name__ == '__main__':	
	for app in apps:
		print("call insertAplicativo('{0}', '{1}', {2}, {3}, '{4}', {5});".format(
				#empresaLogin, nome, tamanho, genero, versao, faixaEtaria
				getEmpresaLogin(),
				app[0],
				rnd(4*2**10, 80*2**20),
				app[1] if app[1] == 'NULL' else ("'"+app[1]+"'"),
				'v{}.{}'.format(rnd(0,48), rnd(1,155)),
				app[2]
			)
		)
