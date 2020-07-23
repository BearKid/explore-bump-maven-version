package com.lwb.build.multimodulesproject.child2;

import com.lwb.build.multimodulesproject.child1.Child1Worker;

public class Child2Worker {
    public void run(){
        new Child1Worker().run();
        System.out.println("run child2 worker");
    }
}
