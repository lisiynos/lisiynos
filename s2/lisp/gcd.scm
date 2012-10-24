#lang racket
; Открываем входной файл как in
(define in (open-input-file "gcd.in"))
; Открываем выходной файл как out, перезаписываем его если он уже есть
(define out (open-output-file "gcd.out" #:exists 'replace))
; Функция gcd, если y равен нулю, то возвращает x, 
; иначе вызывает саму себя с параметрами y и остаток от деления x на y
(define (gcd x y) (if (zero? y) x (gcd y (remainder x y))))
; Считываем два числа из входного файла, передаём их на вход функции gcd и выводим в выходной файл ответ
(display (gcd (read in) (read in)) out)
; Сбрасываем буфер вывода
(flush-output out)