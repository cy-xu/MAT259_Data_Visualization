import java.util.Map;
import java.util.*;

void setup() {
  size(1280, 500, P3D); // setup the size of the window
  background(255);

  loadCSV();
  loadAllTrade();
}