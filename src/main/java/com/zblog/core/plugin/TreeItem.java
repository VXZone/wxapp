package com.zblog.core.plugin;

import java.util.Collection;

public interface TreeItem<T> {

  public Integer getId();

  public Integer getParent();

  public Collection<T> getChildren();

  public void addChild(T child);
  
}
