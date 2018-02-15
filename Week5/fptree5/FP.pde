// Karl Yerkes - 2012/02/09
//
// FP-Growth Data Structure and Algorithm
//   http://www.cs.uiuc.edu/~hanj/pdf/dami04_fptree.pdf
//
// This work is part of the SPL data-mining project
// special thanks to the Robert W. Deutsch Foundation
//

//Terminal$ dot fptree.dot -Tpng -Otree.png


public class FP {

  public Node root;
  public HashMap<String, Node> head;

  public class Node {
    public HashMap<String, Node> child;
    public Node next, parent;
    
    String item;
    Integer support;
    
    int xLoc;
    int yLoc;


    Node(String item) {
      this.item = item;
      child = new HashMap<String, Node>();
      support = 1;
      next = null;
      parent = null;
    }
  }

  public void make(String[] transaction, int minimumSupport) {

    // create new root and head
    //
    root = new Node("");
    head = new HashMap<String, Node>();

    final HashMap<String, Integer> support = new HashMap<String, Integer>();

    class ByDescendingSupport implements Comparator<String> {
      public int compare(String left, String right) {
        return support.get(right).intValue() - support.get(left).intValue();
      }
    } 

    // calculate the support for each item
    //
    for (String t : transaction)
      for (String item : split(t, ",")) {
        Integer i = support.get(item);
        if (i == null)
          support.put(item, new Integer(1));
        else
          support.put(item, new Integer(1 + i.intValue()));
      }

    // remove all items that do not have minimal support
    //
    for (String item : new LinkedList<String>(support.keySet()))
      if (support.get(item).intValue() < minimumSupport)
        support.remove(item);

    // make a list of items sorted first alphabetically, then by descending support
    //
    LinkedList<String> ordered = new LinkedList(support.keySet());
    Collections.sort(ordered);
    Collections.sort(ordered, new ByDescendingSupport());

    for (String item : ordered)
      print(item + ":" + support.get(item).intValue() + " ");
    println();

    // process each transaction
    //
    for (String t : transaction) {

      // list all items that have minimal support
      //
      LinkedList<String> supported = new LinkedList();
      for (String item : split(t, ","))
        if (support.containsKey(item))
          supported.add(item);
 
      // if there are 0 supported items in the transaction, skip it
      //
      if (supported.isEmpty())
        continue;

      print("transaction: ");
      for (String item : split(t, ","))
        print(item + " ");
      print("--> ");

      // sort the list of supported items first alphabetically, then by descending support
      //
      Collections.sort(supported);
      Collections.sort(supported, new ByDescendingSupport());

      print("ordered: ");
      for (String item : supported)
        print(item + " ");
      println();

      insert(root, supported);
    }
  }

  public void insert(Node tree, LinkedList<String> supported) {

    // recursive stopping condition
    //
    if (supported.isEmpty())
      return;

    String item = supported.removeFirst(); 
    Node nextTree = tree.child.get(item);
    if (nextTree == null) {
      nextTree = new Node(item);
      tree.child.put(item, nextTree);
      nextTree.parent = tree;

      Node h = head.get(item);
      if (h == null)
        head.put(item, nextTree);
      else {
        nextTree.next = h;
        head.put(item, nextTree);
      }
    }
    else
      nextTree.support++;

    // recursive call
    //
    insert(nextTree, supported);
  }

  // save a GraphViz (dot) file that shows the FP tree
  //
  // see http://www.graphviz.org/doc/info/lang.html
  //
  public void graphViz(String file) {
    PrintWriter output = createWriter(file);
    output.println("digraph fptree {");
    graphViz(root, output);
    output.println("}");
    output.close();
  }

  // this is the recursive version
  //
  private void graphViz(Node t, PrintWriter output) {
    output.println("  " + t.hashCode() + " [label=\"" + t.item + "\\n" + t.support + "\"];");
    for (Node n : t.child.values()) {

      // recursive call
      //
      graphViz(n, output);
      output.println("  " + n.hashCode() + " -> " + t.hashCode() + ";");
    }
  }

  //Visualization method
  public void graphViz(Node t, int wide, int deep, int siblings, float currentRotation){
    for (Node n : t.child.values()) {
      
      // recursive call
      pushMatrix();    // Save the current state of transformation (i.e. where are we now)
      //println(siblings + " " + wide + " " + (PI*2.0/siblings));
      
      if(deep < 2){
      rotate((PI*2.0/siblings)*wide+deep*0.2);
      rotate(masterRotation);
      }
      else{
      rotate((PI*0.5/siblings)*(wide-(siblings-1)*0.5)+deep*0.2);
      }
      currentRotation += (PI*2.0/siblings)*wide+deep*0.2;
      
      if(displayMode == 1){
        stroke(0);
        fill(0);
        line(0, 0, 0, 170.0/pow(deep,1.1));  // Draw the branch
        translate(0, 170.0/pow(deep,1.1)); // Move to the end of the branch
        ellipse(0,0,sqrt(n.support),sqrt(n.support));
      };
      if(displayMode == 2){
        stroke(200);
        fill(200);
        line(0, 0, 0, 170.0/pow(deep,1.1));  // Draw the branch
        translate(0, 170.0/pow(deep,1.1)); // Move to the end of the branch
        ellipse(0,0,sqrt(n.support),sqrt(n.support));
        
        fill(0);
        rotate(-PI/2);
        fill(0);
        textFont(font1);
        textAlign(CENTER,CENTER);
        text(n.item + " " + n.support,0,10);
        rotate(-PI*1.5);
      };
      wide++;
      graphViz(n, 0, deep+1, n.child.size(), currentRotation);     // Ok, now call myself to draw a new branch
      
      /*float x = modelX(0,0,0);
      float y = modelY(0,0,0);
      */ 
      popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state
      //selection if we're in 3d mode
      /*if(abs(mouseX-x) < 10 && abs(mouseY-y) < 10){
        println(n.item);
      }*/
    }
  }  
}