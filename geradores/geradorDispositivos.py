from random import randint as rnd
from geradorUsuarios import lista as nomes
import time

def getLogin():
	num = rnd(0, len(nomes)-1)
	return nomes[num].split()[0].lower()

def getId(): 
	x = ['moto-e4-', 'moto-g5-', 'galaxy-pocket-', 'galaxy-s7-']
	y = ''.join(map(str, time.localtime()[3:6]))
	pos = rnd(0, len(x)-1)
	return x[pos] + y

def getSO():
	x = [
		'android',
		'ios',
		'windows',
		'linux',
		'os x'
	]
	return x[rnd(0, len(x)-1)]

def getVersion():
	lista = time.localtime()[:2] + (time.localtime()[2] + rnd(1, 99),)
	return '.'.join(map(str, lista))

def getBool():
	return bool(rnd(0,3))

def getCensura():
	x = [10,12,14,16,18]
	i = rnd(0,len(x)-1)
	return x[i] if rnd(0,1) == 0 else 'NULL'

if __name__ == '__main__':
	for i in range(13):
		identify = getId()
		print(
		# (identificador, usuarioLogin, sistema, modelo, versao, certificado, controleParental, updateDisp, notificacao)
			"call insertDispositivo('{}', '{}', '{}', '{}', '{}', {}, {}, {}, {});".format(
				identify[:15], getLogin(), getSO(), identify.split('-')[0], 
				getVersion(), getBool(), getCensura(),
				getBool(), getBool()
			)
		)
