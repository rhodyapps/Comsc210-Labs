import java.util.*
 
fun main() {
 
    val read = Scanner(System.`in`)
 
    println("Enter a:")
    val a = read.nextInt()
 
    println("Enter b:")
    val b = read.nextInt()
 
    val gcd = findGCD(a, b)
 
    println("GCD of $a and $b: $gcd")
}
 
private fun findGCD(a: Int, b: Int): Int {
 
    if(a == 0) return b
 
    return findGCD(b % a, a)
}
