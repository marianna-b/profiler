package net.therapservices.profiler;

/**
 * Created with IntelliJ IDEA.
 * User: Bazlur Rahman Rokon
 * Date: 1/3/13
 * Time: 1:38 AM
 */
public class Demo {
    public static void main(String[] args) throws InterruptedException {
        someMethod();
        someMethod1();
        someMethod2();
        someMethod3();
        someMethod4();
        someMethod5();
        someMethod();
        someMethod1();
        someMethod2();
        someMethod3();
        someMethod4();
        someMethod5();
    }

    public static void someMethod() throws InterruptedException {
        Thread.sleep(100);
        someMethod4();
    }

    public static void someMethod1() throws InterruptedException {
        Thread.sleep(200);
    }

    public static void someMethod2() throws InterruptedException {
        Thread.sleep(300);
    }

    public static void someMethod3() throws InterruptedException {
        Thread.sleep(400);
    }

    public static void someMethod4() throws InterruptedException {
        Thread.sleep(500);
    }

    public static void someMethod5() throws InterruptedException {
        Thread.sleep(600);
    }
}
