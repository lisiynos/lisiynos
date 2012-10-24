#lang racket
; Открываем входной файл как in
(define in(open-input-file"rpn.in"))
; Открываем выходной файл как out, перезаписываем его если он уже есть
(define out(open-output-file"rpn.out"#:exists 'replace))

; Выполнение операции
(define (do f e s operation) 
  (f 
   (cdr e) 
   (cons (operation (car (cdr s)) (car s)) (cdr (cdr s)))))

; Функция f: e - оставшаяся часть выражения, s - стек
(define (f e s)
  (if(null? e)
     (car s)         
     (if(eq? (car e) '+) (do f e s +)
        (if(eq? (car e) '-) (do f e s -)
           (if(eq? (car e) '*) (do f e s *)
              (if(eq? (car e) '/) (do f e s /)
                 (f (cdr e) (cons (car e) s)))
              )))))

; Считываем из входного файла, подаём на вход функции f и выводим результат в выходной файл
(display (f (read in) '()) out)
; Сбрасываем буфер вывода
(flush-output out)
