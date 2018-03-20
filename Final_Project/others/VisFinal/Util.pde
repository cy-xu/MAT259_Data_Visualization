PVector sphereToXYZ(float lat, float longt, float rad) {
  PVector result = new PVector();
  float latR = lat / 180.0 * PI;
  float longR = longt / 180.0 * PI;
  result.x = -rad*cos(latR)*cos(longR);
  result.z = rad*cos(latR)*sin(longR);
  result.y = -rad*sin(latR);
  return result;
}

int mapFloatToYear(float x) {
  float rtx = sqrt(sqrt(x));
  float l = rtx * 4018;
  l -= 2000;
  return (int)(l);
}

float log2 (float x) {
  return (log(x) / log(2));
}

float getZeroOneRange(float val, float min, float max) {
  float result = 0;
  if (val < min) return 0;
  if (val > max) return 1;
  if ((max - min) > 1e-7) {
    result =  (val - min) / (max - min);
  }
  return result;
}

Vec3D rndSampleSphere(float thetaR, float phiR, Vec3D axisUp) {
  Vec3D result = new Vec3D(0,0,0);
  float theta = random(0,1) * thetaR;
  float phi = random(0,1) * phiR;
  
  float x = sin(theta)*cos(phi);
  float y = cos(theta);
  float z = sin(theta)*sin(phi);
  result.x = x;
  result.y = y;
  result.z = z;
  
  float angleRad = PI - acos(axisUp.dot(new Vec3D(0,1,0)));
  Vec3D axis = axisUp.cross(new Vec3D(0,1,0));
  axis.normalize();
  return result.getRotatedAroundAxis(axis, angleRad);
}

// Binary search through list.
int binarySearchInt(IntList list, int val) {
  int result = 0;
  
  int low = 0;
  int high = list.size() - 1;
  int mid = (low + high) / 2;
  while (true) {
    mid = (low + high) / 2;
    if (list.get(mid) == val || mid == low || mid == high) {
      break;
    }
    if (list.get(mid) < val) {
      low = mid;
    }
    if (list.get(mid) > val) {
      high = mid;
    }
  }
  return mid;
}