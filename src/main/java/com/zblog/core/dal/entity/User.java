package com.zblog.core.dal.entity;

import com.zblog.core.dal.constants.UserConstants;

public class User extends BaseEntity{
  private String username;
  private String password;
  private String avatar;
  private String mobile;
  private String email;
  /* 用户账号状态 */
  private String status = UserConstants.USER_STATUS_NORMAL;
  private String role = UserConstants.USER_ROLE_CONTRIBUTOR;
  private String description;

  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  public String getPassword(){
    return password;
  }

  public void setPassword(String password){
    this.password = password;
  }

  public String getAvatar() {
    return avatar;
  }

  public void setAvatar(String avatar) {
    this.avatar = avatar;
  }

  public String getMobile() {
    return mobile;
  }

  public void setMobile(String mobile) {
    this.mobile = mobile;
  }

  public String getEmail(){
    return email;
  }

  public void setEmail(String email){
    this.email = email;
  }

  public String getStatus(){
    return status;
  }

  public void setStatus(String status){
    this.status = status;
  }

  public String getRole(){
    return role;
  }

  public void setRole(String role){
    this.role = role;
  }

  public String getDescription(){
    return description;
  }

  public void setDescription(String description){
    this.description = description;
  }

}
