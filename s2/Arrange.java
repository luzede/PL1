import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.LinkedList;

class Node {
    int val;
    Node left;
    Node right;

    Node(int val) {
        this.val = val;
        this.left = null;
        this.right = null;
    }
    
    Node(int val, Node left, Node right) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

public class Arrange {
    public static Node buildTree(LinkedList<Integer> list) {
        if (list.isEmpty()) return null;

        int v = list.removeFirst();
        
        if (v == 0) return null;
        
        return new Node(v, buildTree(list), buildTree(list));
    }

    public static void inorderTraversal(Node root, LinkedList<Integer> result) {
        if (root == null)
            return;

        inorderTraversal(root.left, result);
        result.add(root.val);
        inorderTraversal(root.right, result);
    }

    public static int order_lex_min(Node root) {
        // If it is a leaf node, return its value
        if (root.left == null && root.right == null) return root.val;
        
        // If left is null, swap left and right only if right is less than root
        if (root.left == null) {
            int minr = order_lex_min(root.right);
            if (minr < root.val) {
                root.left = root.right;
                root.right = null;
                return minr;
            }
            return root.val;
        }

        // If right is null, swap left and right only if left is less than root
        if (root.right == null) {
            int minl = order_lex_min(root.left);
            if (root.val < minl) {
                root.right = root.left;
                root.left = null;
                return root.val;
            }
            return minl;
        }

        int minl = order_lex_min(root.left);
        int minr = order_lex_min(root.right);

        // If right is less than left, swap and return the value of right
        if (minr < minl) {
            Node temp = root.right;
            root.right = root.left;
            root.left = temp;
            return minr;
        }
        // Else return the value of left
        else {
            return minl;
        }

    }


    public static void main(String[] args) {
        if (args.length < 1) {
            System.out.println("Usage: java Arrange <input_file>");
            return;
        }

        String fileName = args[0];
        try (BufferedReader br = new BufferedReader(new FileReader(fileName))) {
            int n = Integer.parseInt(br.readLine());
            String[] line = br.readLine().split(" ");
            LinkedList<Integer> values = new LinkedList<>();
            for (String s : line) {
                values.add(Integer.parseInt(s));
            }

            Node root = buildTree(values);
            order_lex_min(root);

            LinkedList<Integer> result = new LinkedList<>();
            inorderTraversal(root, result);

            for (int num : result) {
                System.out.print(num + " ");
            }
            System.out.println();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
