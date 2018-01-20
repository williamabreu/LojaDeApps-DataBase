import random

arq = open('tableDevs.csv', 'r')
arq.readline()

i = 0

for line in arq:
	login = line.split(',')[0]
	#       12345678901234567890
	fone = '+55 35 3{:03}-{:04}'.format(random.randint(0,999), random.randint(0,9999))
	print("call insertTelefone('{0}', '{1}');".format(fone, login))
	
	if i % 2 == 0:
		fone = '+55 35 4{:03}-{:04}'.format(random.randint(0,999), random.randint(0,9999))
		print("call insertTelefone('{0}', '{1}');".format(fone, login))
	
	if i % 3 == 0:
		fone = '+55 35 9{:03}-{:04}'.format(random.randint(0,999), random.randint(0,9999))
		print("call insertTelefone('{0}', '{1}');".format(fone, login))
	
	i += 1
