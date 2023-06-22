let bg;
let uTable;
let cTable;
let uNucs = [];
let cNucs = [];
let scaleFactor = 2;
let uTracer;
let uSeekers = [];
let uTargets = [];
let cS = [];
let cT = [];


class dotNucleus {
  constructor(x,y,index) {
    this.x = x/scaleFactor;
    this.y = y/scaleFactor;
    this.d = 12/scaleFactor;
    this.i = index;
    this.color = '#888888'
    this.counted = false;
  }
  display() {
    noStroke();
    fill(this.color);
    circle(this.x, this.y, this.d);
  }
}

class uN extends dotNucleus{
  constructor(x,y,index) {
    super(x,y,index)
    this.color = '#830DAB'
  }
}

class cN extends dotNucleus{
  constructor(x,y,index) {
    super(x,y,index)
    this.color = '#FD800A'
  }
}


function preload() {
  uTable = loadTable('assets/U_missing.csv', 'header')
  cTable = loadTable('assets/N_points.csv', 'header')
}

function loadData() {
  const cData = cTable.getRows();
  
  for (let i = 0; i < cTable.getRowCount(); i++) {
    // Get position, diameter, name,
    const x = cData[i].getNum("axis-1");
    const y = cData[i].getNum("axis-0");
    const index = cData[i].getNum("index");

    // Put object in array
    cNucs.push(new cN(x, y, index));
  }
  
  const uData = uTable.getRows();
  
  for (let i = 0; i < uTable.getRowCount(); i++) {
    // Get position, diameter, name,
    const x = uData[i].getNum("axis-1");
    const y = uData[i].getNum("axis-0");
    const index = uData[i].getNum("index");

    // Put object in array
    uNucs.push(new uN(x, y, index));
  }
}


class Seeker {
  constructor(x,y){
    this.pos = createVector(x,y);
    this.vel = createVector(random(-10,10),random(-10,10)); // initial velocity vector
    this.acc = createVector();
    this.maxSpeed = 50;
    this.maxForce = 5;
    this.color = '#830DAB';
  }
  
  seek(target) {
    let force = p5.Vector.sub(target,this.pos)
    force.setMag(this.maxSpeed);
    force.sub(this.vel);
    force.limit(this.maxForce);
    this.applyForce(force);
  }
  applyForce(force) {
    this.acc.add(force);
  }
  update() {
    this.vel.add(this.acc);
    this.vel.limit(this.maxSpeed);
    this.pos.add(this.vel);
    this.acc.mult(0); // reset acceleration
    this.maxSpeed = this.maxSpeed/1.02; //gradually decreasing speed
  }
  
  arrive(target) {
    let force = p5.Vector.sub(target,this.pos)
    var d = force.mag();
    if (d<200) {
      var m = map(d, 0, 100, 0, this.maxSpeed);
      force.setMag(m);
    } else {
      force.setMag(this.maxSpeed);
    }
    force.sub(this.vel);
    force.limit(this.maxForce);
    this.applyForce(force);
  }
  
  display() {
    noStroke();
    fill(this.color);
    circle(this.pos.x, this.pos.y, 16/scaleFactor);
    //this.prev.x = this.pos.x;
    //this.prev.y = this.pos.y;

  }

}

class cSeeker extends Seeker{
  constructor(x,y) {
    super(x,y)
    this.color = '#FD800A'
  }
}

function setup() {
  // The background image must be the same size as the parameters
  // into the createCanvas() method. In this program, the size of
  // the image is 720x400 pixels.
  bg = loadImage('assets/N_mip.png');
  loadData();
  for (let i = 0; i < uNucs.length; i++) {
    //uSeekers.push(new Seeker(0,random(1024)));
    uSeekers.push(new Seeker((1024/scaleFactor)/4,(1024/scaleFactor)/2));
    uTargets.push(new createVector(uNucs[i].x,uNucs[i].y));
  }
  for (let i = 0; i < cNucs.length; i++) {
    //cS.push(new cSeeker(random(1024/scaleFactor),random(1024/scaleFactor)));
    //cS.push(new cSeeker(random(1024/scaleFactor/10),0));
    cS.push(new cSeeker((1024/scaleFactor)*3/4,(1024/scaleFactor)/2));
    cT.push(new createVector(cNucs[i].x,cNucs[i].y));
  }
  createCanvas(1024/scaleFactor, 1024/scaleFactor);
  frameRate(30);
  //createLoop({duration:35, gif:{download:true}})
  createLoop({duration:35, gif:{open:true}})
  
}


function draw() {
  background(bg);
  //print('cN length: ' + cNucs.length);
  //// Display all bubbles
  for (let i = 0; i < cNucs.length; i++) {
    if (i<frameCount) {
    //cNucs[i].display();
      cS[i].seek(cT[i]);
      cS[i].update();
      cS[i].display();
    }
  }
  //for (let i = 0; i < 2; i++) {
  for (let i = 0; i < uNucs.length; i++) {
    //uNucs[i].display();
    if (i*3<frameCount) {
      uSeekers[i].seek(uTargets[i]);
      uSeekers[i].update();
      uSeekers[i].display();
    }
  }
  
}
