void gui() {
  pushMatrix();
  hint(DISABLE_DEPTH_TEST);
  cam.beginHUD();
  //text("FPS: "+frameRate,50,50); 
  cp5.draw();
  drawTitle();
  cam.endHUD();
  hint(ENABLE_DEPTH_TEST);
  popMatrix();
}

void SingleGenre(boolean flag)
{
  singleMode = flag;
  if (flag == true)
  {
    Toggle toggle = ((Toggle)cp5.getController("SingleGenre"));
    toggle.setColorBackground(toggled);
    if(initState == false)
    {
      initState = true;
    }
    else
    {
       setElseFalse("Action");
    }
  } else
  {
    Toggle toggle = ((Toggle)cp5.getController("SingleGenre"));
    toggle.setColorBackground(untoggled);
  }
}

void Action(boolean flag)
{
  //println("Action");
  setShowGenre("Action", flag);
  if (flag == true)
  {
    Toggle toggle = ((Toggle)cp5.getController("Action"));
    toggle.setColorBackground(toggled);
    if (singleMode == true)
    {
      setElseFalse("Action");
    }
  } else
  {
    Toggle toggle = ((Toggle)cp5.getController("Action"));
    toggle.setColorBackground(untoggled);
  }
}

void Documentary(boolean flag)
{
  //println("Documentary");
  setShowGenre("Documentary", flag);
  if (flag == true)
  {
    Toggle toggle = ((Toggle)cp5.getController("Documentary"));
    toggle.setColorBackground(toggled);
    if (singleMode == true)
    {
      setElseFalse("Documentary");
    }
  } else
  {
    Toggle toggle = ((Toggle)cp5.getController("Documentary"));
    toggle.setColorBackground(untoggled);
  }
}

void Western(boolean flag)
{
  //println("Western");
  setShowGenre("Western", flag);
  if (flag == true)
  {
    Toggle toggle = ((Toggle)cp5.getController("Western"));
    toggle.setColorBackground(toggled);
    if (singleMode == true)
    {
      setElseFalse("Western");
    }
  } else
  {
    Toggle toggle = ((Toggle)cp5.getController("Western"));
    toggle.setColorBackground(untoggled);
  }
}

void Mystery(boolean flag)
{
  //println("Mystery");
  setShowGenre("Mystery", flag);
  if (flag == true)
  {
    Toggle toggle = ((Toggle)cp5.getController("Mystery"));
    toggle.setColorBackground(toggled);
    if (singleMode == true)
    {
      setElseFalse("Mystery");
    }
  } else
  {
    Toggle toggle = ((Toggle)cp5.getController("Mystery"));
    toggle.setColorBackground(untoggled);
  }
}

void Family(boolean flag)
{
  //println("Family");
  setShowGenre("Family", flag);
  if (flag == true)
  {
    Toggle toggle = ((Toggle)cp5.getController("Family"));
    toggle.setColorBackground(toggled);
    if (singleMode == true)
    {
      setElseFalse("Family");
    }
  } else
  {
    Toggle toggle = ((Toggle)cp5.getController("Family"));
    toggle.setColorBackground(untoggled);
  }
}

void Animation(boolean flag)
{
  //println("Animation");
  setShowGenre("Animation", flag);
  if (flag == true)
  {
    Toggle toggle = ((Toggle)cp5.getController("Animation"));
    toggle.setColorBackground(toggled);
    if (singleMode == true)
    {
      setElseFalse("Animation");
    }
  } else
  {
    Toggle toggle = ((Toggle)cp5.getController("Animation"));
    toggle.setColorBackground(untoggled);
  }
}

void Crime(boolean flag)
{
  //println("Crime");
  setShowGenre("Crime", flag);
  if (flag == true)
  {
    Toggle toggle = ((Toggle)cp5.getController("Crime"));
    toggle.setColorBackground(toggled);
    if (singleMode == true)
    {
      setElseFalse("Crime");
    }
  } else
  {
    Toggle toggle = ((Toggle)cp5.getController("Crime"));
    toggle.setColorBackground(untoggled);
  }
}

void Comedy(boolean flag)
{
  //println("Comedy");
  setShowGenre("Comedy", flag);
  if (flag == true)
  {
    Toggle toggle = ((Toggle)cp5.getController("Comedy"));
    toggle.setColorBackground(toggled);
    if (singleMode == true)
    {
      setElseFalse("Comedy");
    }
  } else
  {
    Toggle toggle = ((Toggle)cp5.getController("Comedy"));
    toggle.setColorBackground(untoggled);
  }
}

void Adventure(boolean flag)
{
  //println("Adventure");
  setShowGenre("Adventure", flag);
  if (flag == true)
  {
    Toggle toggle = ((Toggle)cp5.getController("Adventure"));
    toggle.setColorBackground(toggled);
    if (singleMode == true)
    {
      setElseFalse("Adventure");
    }
  } else
  {
    Toggle toggle = ((Toggle)cp5.getController("Adventure"));
    toggle.setColorBackground(untoggled);
  }
}

void ScienceFiction(boolean flag)
{
  //println("Science Fiction");
  setShowGenre("ScienceFiction", flag);
  if (flag == true)
  {
    Toggle toggle = ((Toggle)cp5.getController("ScienceFiction"));
    toggle.setColorBackground(toggled);
    if (singleMode == true)
    {
      setElseFalse("ScienceFiction");
    }
  } else
  {
    Toggle toggle = ((Toggle)cp5.getController("ScienceFiction"));
    toggle.setColorBackground(untoggled);
  }
}


void Drama(boolean flag)
{
  //println("Drama");
  setShowGenre("Drama", flag);
  if (flag == true)
  {
    Toggle toggle = ((Toggle)cp5.getController("Drama"));
    toggle.setColorBackground(toggled);
    if (singleMode == true)
    {
      setElseFalse("Drama");
    }
  } else
  {
    Toggle toggle = ((Toggle)cp5.getController("Drama"));
    toggle.setColorBackground(untoggled);
  }
}


void Romance(boolean flag)
{
  //println("Romance");
  setShowGenre("Romance", flag);
  if (flag == true)
  {
    Toggle toggle = ((Toggle)cp5.getController("Romance"));
    toggle.setColorBackground(toggled);
    if (singleMode == true)
    {
      setElseFalse("Romance");
    }
  } else
  {
    Toggle toggle = ((Toggle)cp5.getController("Romance"));
    toggle.setColorBackground(untoggled);
  }
}


void Horror(boolean flag)
{
  //println("Horror");
  setShowGenre("Horror", flag);
  if (flag == true)
  {
    Toggle toggle = ((Toggle)cp5.getController("Horror"));
    toggle.setColorBackground(toggled);
    if (singleMode == true)
    {
      setElseFalse("Horror");
    }
  } else
  {
    Toggle toggle = ((Toggle)cp5.getController("Horror"));
    toggle.setColorBackground(untoggled);
  }
}


void Thriller(boolean flag)
{
  //println("Thriller");
  setShowGenre("Thriller", flag);
  if (flag == true)
  {
    Toggle toggle = ((Toggle)cp5.getController("Thriller"));
    toggle.setColorBackground(toggled);
    if (singleMode == true)
    {
      setElseFalse("Thriller");
    }
  } else
  {
    Toggle toggle = ((Toggle)cp5.getController("Thriller"));
    toggle.setColorBackground(untoggled);
  }
}


void Fantasy(boolean flag)
{
  //println("Fantasy");
  setShowGenre("Fantasy", flag);
  if (flag == true)
  {
    Toggle toggle = ((Toggle)cp5.getController("Fantasy"));
    toggle.setColorBackground(toggled);
    if (singleMode == true)
    {
      setElseFalse("Fantasy");
    }
  } else
  {
    Toggle toggle = ((Toggle)cp5.getController("Fantasy"));
    toggle.setColorBackground(untoggled);
  }
}


void Music(boolean flag)
{
  //println("Music");
  setShowGenre("Music", flag);
  if (flag == true)
  {
    Toggle toggle = ((Toggle)cp5.getController("Music"));
    toggle.setColorBackground(toggled);
    if (singleMode == true)
    {
      setElseFalse("Music");
    }
  } else
  {
    Toggle toggle = ((Toggle)cp5.getController("Music"));
    toggle.setColorBackground(untoggled);
  }
}

void War(boolean flag)
{
  //println("War");
  setShowGenre("War", flag);
  if (flag == true)
  {
    Toggle toggle = ((Toggle)cp5.getController("War"));
    toggle.setColorBackground(toggled);
    if (singleMode == true)
    {
      setElseFalse("War");
    }
  } else
  {
    Toggle toggle = ((Toggle)cp5.getController("War"));
    toggle.setColorBackground(untoggled);
  }
}


void History(boolean flag)
{
  //println("History");
  setShowGenre("History", flag);
  if (flag == true)
  {
    Toggle toggle = ((Toggle)cp5.getController("History"));
    toggle.setColorBackground(toggled);
    if (singleMode == true)
    {
      setElseFalse("History");
    }
  } else
  {
    Toggle toggle = ((Toggle)cp5.getController("History"));
    toggle.setColorBackground(untoggled);
  }
}

void setElseFalse(String name)
{
  int indexInToggle = toggleLabel.indexOf(name);
  int indexInGraph = 0;
  if (name == "ScienceFiction")
    indexInGraph = genre.indexOf("Science Fiction");
  else
    indexInGraph = genre.indexOf(name);

  for (int i = 1; i < toggleLabel.size(); i++)
  {
    Toggle toggle = ((Toggle)cp5.getController(toggleLabel.get(i)));
    if (toggle.getState() == true && i != indexInToggle)
    {
      println("processing toggle", toggleLabel.get(i));
      toggle.setValue(false);
      toggle.setColorBackground(untoggled);
      toggle.update();
    }
  }

  for (int i = 0; i < genre.size(); i++)
  {
    showGenre[i] = false;
  }
  showGenre[indexInGraph] = true;
  println("setElseFalse:", "show[" + genre.get(indexInGraph) + "] = ", showGenre[indexInGraph]);
}


void setShowGenre(String name, boolean flag)
{
  int indexInGraph = 0;
  if (name == "ScienceFiction")
  {
    indexInGraph = genre.indexOf("Science Fiction");
  } else
  {
    indexInGraph = genre.indexOf(name);
  }
  showGenre[indexInGraph] = flag;
  //println("show[" + genre.get(indexInGraph) + "] = ", showGenre[indexInGraph]);
}


void setUpToggle()
{
  float toggleTop = (height - toggleHeight * toggleLabel.size()) / 2;

  for (int i = 0; i < toggleLabel.size(); i++)
  {

    if (i == 0)
    {
      cp5.addToggle(toggleLabel.get(0))
        .setPosition(width - marginLeft, i * toggleHeight + toggleTop)
        .setSize(70, 15)
        .setMode(ControlP5.SWITCH)
        .setColorActive(#ffffff)
        .setColorBackground(untoggled)
        .setLabel("Single Genre Mode")
        .setValue(true);
    } else if (toggleLabel.get(i) == "ScienceFiction")
    {
      cp5.addToggle(toggleLabel.get(i))
        .setPosition(width - marginLeft, i * toggleHeight + toggleTop)
        .setSize(40, 15)
        .setMode(ControlP5.SWITCH)
        .setColorActive(#ffffff)
        .setColorBackground(untoggled)
        .setLabel("Science Fiction")
        .setValue(false);
    } else
    {
      cp5.addToggle(toggleLabel.get(i))
        .setPosition(width - marginLeft, i * toggleHeight + toggleTop)
        .setSize(40, 15)
        .setMode(ControlP5.SWITCH)
        .setColorActive(#ffffff)
        .setColorBackground(untoggled)
        .setValue(false);
    }
  }
  cp5.setAutoDraw(false);
}