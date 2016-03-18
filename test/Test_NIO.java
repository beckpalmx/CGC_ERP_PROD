/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author beckpalmx
 */
import java.nio.*;

public class Test_NIO {

    public static void main(String[] args) {
        ByteBuffer buf = ByteBuffer.allocate(1024);
        System.out.println("position is " + buf.position());
        System.out.println("limit is " + buf.limit());
        System.out.println("capacity is " + buf.capacity());
//position limit
        buf.position(100).limit(512);
        System.out.println("\nAfter call buf.position(100).limit(512);");
        System.out.println("position is " + buf.position());
        System.out.println("limit is " + buf.limit());
        System.out.println("capacity is " + buf.capacity());
    }
}
