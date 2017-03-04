package net.therapservices.profiler;

import org.aspectj.lang.Signature;

import java.util.*;


public aspect MethodExecutionTimeProfiler {
    private String curr = "";
    private int depth = 0;
    private Map<Signature, Integer> count = new HashMap<Signature, Integer>();
    private Map<Signature, Long> timeSum = new HashMap<Signature, Long>();
    private Map<String, Integer> treeCount = new HashMap<String, Integer>();
    private Map<String, Long> treeSum = new HashMap<String, Long>();
    pointcut methodExecutionTime(): execution(public * * (..));

    Object around (): methodExecutionTime(){
        long statTime = System.currentTimeMillis();
        for (int i = 0; i < depth; i++) {
            System.out.print(" ");
        }
        System.out.println(thisJoinPoint.getSignature().getName());
        if (depth > 0)
            curr += ".";
        curr += thisJoinPoint.getSignature().getName();
        depth++;

        Object ret = proceed();
        long finTime = System.currentTimeMillis();

        int r = 0;
        long s = 0;
        if (treeCount.containsKey(curr)) {
            r = treeCount.get(curr);
            s = treeSum.get(curr);
        }
        treeCount.put(curr, r + 1);
        treeSum.put(curr, s + (finTime - statTime));

        Signature name = thisJoinPoint.getSignature();
        int c = 0;
        long sum = 0;
        if (count.containsKey(name)) {
            c = count.get(name);
            sum = timeSum.get(name);
        }
        count.put(name, c + 1);
        timeSum.put(name, sum + (finTime - statTime));

        depth--;
        if (depth == 0)
            curr = "";
        else
            curr = curr.substring(0, curr.length() - thisJoinPoint.getSignature().getName().length() - 1);

        if (depth == 0) {
            for (Object o : count.entrySet()) {
                Map.Entry thisEntry = (Map.Entry) o;
                Signature key = (Signature) thisEntry.getKey();
                Integer value = (Integer) thisEntry.getValue();
                Long sumTime = timeSum.get(key);
                Long avg = sumTime / value;
                System.out.println(key + " count: " + value + " sum: " + sumTime + " avg: " + avg);
            }
            List<String> list = new ArrayList<String>();
            for (Object o : treeCount.entrySet()) {
                Map.Entry thisEntry = (Map.Entry) o;
                String key = (String) thisEntry.getKey();
                list.add(key);
            }
            Collections.sort(list);
            for (String elem : list) {
                Integer value = treeCount.get(elem);
                Long sumTime = treeSum.get(elem);
                Long avg = sumTime / value;
                System.out.println(elem + " count: " + value + " sum: " + sumTime + " avg: " + avg);
            }

        }
        return ret;
    }


}
