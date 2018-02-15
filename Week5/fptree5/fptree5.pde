// Karl Yerkes - 2012/02/09
//
// FP-Growth Data Structure and Algorithm
//   http://www.cs.uiuc.edu/~hanj/pdf/dami04_fptree.pdf
//
// This work is part of the SPL data-mining project
//
// special thanks to the Robert W. Deutsch Foundation
//
// next steps...
// 1) run this on a BIGGER dataset
// 2) find all conditional frequency patterns (see dami04)
//
import java.util.*;

int minimumSupport = 80;
FP fp = new FP();
PFont font1 = createFont("Helvetica", 10);
float spread = 0.2;
int displayMode = 1;
float masterRotation = 0.0;

void setup() {
  size(800,600);
  smooth();

  // each comma delimited string needs to represent a set of things that are associated in the dataset.
  // this example uses some titles that have to do with Alaska or are nearby alphabetically. note that
  // within each transaction set, items must be unique.  that means that "a,b,c" is good, but "a,b,c,a"
  // is BAD.  i've added code at the end of this file that cleans up titles.  for instance, the title:
  //
  //   "Alaska,A,to,Z,the,most,comprehensive,book,of,facts,and,figures,ever,compiled,about,Alaska",
  // 
  // has "Alaska" in there twice.. BAD.  also, words like "to and of" are removed with clean(...)
  //
  String transaction[] = loadStrings("savedData.txt");
  println("QUERY: " + transaction[0]);
  for (int i=1; i < transaction.length; i++) {
    
    
    transaction[i] = transaction[i].replace('^', ',');
    String temp = transaction[i];
    println(temp);

  }  


  
  fp.make(clean(transaction), minimumSupport);

  // this makes a .dot file that can be visualized with GraphViz
  //
  // on the terminal do:
  //   'brew install graphviz' then
  //   'dot -T svg -o fptree.svg fptree.dot && open fptree.svg'
  //
  fp.graphViz("fptree.dot");
  //exit();
}

void draw(){
  background(255);
  
  spread = height/((float)mouseY+1.0)*0.01;
  translate(width/2,height);
  translate(0,-height/2);
  rotate(180);
  fp.graphViz(fp.root, 0, 1, fp.root.child.size(), 0.0);
  
}
// this is like grep/sort/uniq in one function
//
String[] clean(String[] transaction) {
  HashSet<String> ignore = new HashSet<String>(); 
  for (String s : new String[] {"the", "in", "on", "at", "of", "a", "and", "an", "to", "by"})
  /*
  ^de$|^i$|^ii$|^by$|^is$|^r$|^m$|^at$|^etc$|^jones$|^him$|^ex$|hearing|impaired|pimsleur|juvenile|
  course|complete|^with$|description|instruction|self|search|video|self|language|english|recording|
  speakers|^in$|film|^why$|^from$|sound|program|suspense|history|united|states|fiction|^my$|^an$|^your$
  |^are$|^the$|^who$|^which$|^it$|^null$|^for$|^and$|^to$|^a$|^b$|^c$|^of$|^while$|^that$|^on$|^off$|^[0-9]
  */
    ignore.add(s);

  LinkedList<String> output = new LinkedList<String>();
  for (String t : transaction) {
    HashSet<String> hash = new HashSet<String>();
    for (String s : split(t, ","))
      if (! ignore.contains(s))
        hash.add(s);
    output.add(join(hash.toArray(new String[0]), ","));
  }
  return output.toArray(new String[0]);
}

void keyPressed(){
 if(key == '1'){
   displayMode = 1;
 } 
 if(key == '2'){
   displayMode = 2;
 }
 if(key == ','){
   masterRotation -= 0.1;
 }
  if(key == '.'){
   masterRotation += 0.1;
 }
}