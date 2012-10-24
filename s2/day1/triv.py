from math import sqrt

def trivial(n):
    sum = 1   # Сумма делителей
    for i in range(2, int(sqrt(n)) + 1):
        if n % i == 0:
            sum += i
            ii = n // i  # Парный делитель
            if ii != i:
                sum += ii
    return sum / n



print("<table>")
for i in range(2,14):
  s = []
  for k in range(1,i):
    if i % k == 0: 
      s.append(k)

  print("<tr><td>$\\frac{"+("+".join([str(x) for x in s]))+"}{",i,"}=\\frac{",sum(s),'}{',i,'}=',sum(s)/i,"$</td></tr>")
   
print("</table>")


