*scheme*
{
    一流的函数&优化的尾递归
}


*debug工具*
{
    code.cs61a.org/scheme 
    python3 editor
    python3 scheme
    python3 scheme -i <file.scm>
}


*quote*
{
    这个引用很神奇，没怎么搞明白
    目前理解是，引用的部分原模原样传给函数
    不要在传入之前自己加工简化
    如果引用的东西函数能认出那就OK
}

*function*
{
    // 函数
    scm> (define foo (lambda (x y) (+ x y)))
    foo
    scm> (define (foo x y) (+ x y))
    foo

    // lambda 函数
    scm> (lambda (x y) (+ x y))        ; Returns a lambda function, but doesn't assign it to a name
    (lambda (x y) (+ x y))
    scm> ((lambda (x y) (+ x y)) 3 4)  ; Create and call a lambda function in one line
    7
}


*other operators*
{
    modulo    取余
    quotient  整除
    \         除
}