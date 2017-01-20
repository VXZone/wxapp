
package com.zblog.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zblog.core.dal.constants.ChannelConstants;
import com.zblog.core.dal.entity.Channel;
import com.zblog.core.dal.mapper.BaseMapper;
import com.zblog.core.dal.mapper.ChannelMapper;
import com.zblog.core.dal.mapper.PostMapper;
import com.zblog.core.util.IdGenerator;
import com.zblog.core.util.StringUtils;

@Service
public class ChannelService extends BaseService{
    @Autowired
    private ChannelMapper channelMapper;
    @Autowired
    private PostMapper postMapper;

    @Transactional
    public boolean insertChildren(Channel channel, String parentName){
        Channel parent = loadByName(StringUtils.isBlank(parentName) ? ChannelConstants.ROOT : parentName);
        channel.setLeftv(parent.getRightv());
        channel.setRightv(parent.getRightv() + 1);

        channelMapper.updateInsertLeftv(parent.getRightv());
        channelMapper.updateInsertRightv(parent.getRightv());
        insert(channel);

        return true;
    }

    @Transactional
    public boolean insertAfter(Channel channel, Channel sbling){
        channel.setLeftv(sbling.getRightv() + 1);
        channel.setRightv(sbling.getRightv() + 2);

        channelMapper.updateInsertLeftv(sbling.getRightv());
        channelMapper.updateInsertRightv(sbling.getRightv());
        insert(channel);

        return true;
    }

    /**
     * 此方法只被ChannelManager调用
     *
     * @param channel
     * @return
     */
    @Transactional
    public void remove(Channel channel){
        int length = channel.getRightv() - channel.getLeftv() + 1;
    /* 注意:delete须第一个执行,因为updateDeleteLeftv会有影响 */
        channelMapper.delete(channel.getLeftv(), channel.getRightv());
        channelMapper.updateDeleteLeftv(channel.getLeftv(), length);
        channelMapper.updateDeleteRightv(channel.getRightv(), length);
    }

    /**
     * 获取指定分类的子分类
     *
     * @param channel
     * @return
     */
    public List<Channel> loadChildren(Channel channel){
        return channelMapper.loadChildren(channel);
    }

    public void init(){
        Channel root = new Channel();
        //root.setId(IdGenerator.uuid19());
        root.setLeftv(1);
        root.setName(ChannelConstants.ROOT);
        root.setRightv(2);
        insert(root);
    }

    public Channel loadByName(String name){
        return channelMapper.loadByName(name);
    }

    @Override
    protected BaseMapper getMapper(){
        return channelMapper;
    }

}
