local function modadd(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    -- superuser and admins only (because sudo are always has privilege)
    if not is_admin(msg) then
   if not lang then
        return '_You are not bot admin_'
else
     return 'شما مدیر ربات نمیباشید'
    end
end
    local data = load_data(_config.moderation.data)
  if data[tostring(msg.to.id)] then
if not lang then
   return '_Group is already added_'
else
return 'گروه در لیست گروه های مدیریتی ربات هم اکنون موجود است'
  end
end
        -- create data array in moderation.json
      data[tostring(msg.to.id)] = {
              owners = {},
      mods ={},
      banned ={},
      is_silent_users ={},
      filterlist ={},
      whitelist ={},
      settings = {
          set_name = msg.to.title,
          lock_link = 'yes',
          lock_tag = 'yes',
		  lock_username = 'yes',		  		  
          lock_spam = 'yes',
          lock_webpage = 'no',
          lock_mention = 'no',
          lock_markdown = 'no',
          lock_flood = 'yes',
          lock_bots = 'yes',
          lock_pin = 'no',
          welcome = 'no',
		  lock_join = 'no',
		  lock_badword = 'no',
		  lock_tabchi = 'no',
		  lock_english = 'no',		  
                 mute_fwd = 'no',
                  mute_audio = 'no',
                  mute_video = 'no',
                  mute_contact = 'no',
                  mute_text = 'no',
                  mute_photos = 'no',
                  mute_gif = 'no',
                  mute_loc = 'no',
                  mute_doc = 'no',
                  mute_sticker = 'no',
                  mute_voice = 'no',
                   mute_all = 'no',
				   mute_keyboard = 'no'
				},
				
                 }
  save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)
    if not lang then
  return "`Group` *has been added*\n*OяƊєя Ɓу :* `"..msg.from.id.."` "
else
  return 'گروه با موفقیت به لیست گروه های مدیریتی ربات افزوده شد'
end
end

local function modrem(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    -- superuser and admins only (because sudo are always has privilege)
      if not is_admin(msg) then
     if not lang then
        return '_You are not bot admin_'
   else
        return 'شما مدیر ربات نمیباشید'
    end
   end
    local data = load_data(_config.moderation.data)
    local receiver = msg.to.id
  if not data[tostring(msg.to.id)] then
  if not lang then
    return '_Group is not added_'
else
    return 'گروه به لیست گروه های مدیریتی ربات اضافه نشده است'
   end
  end

  data[tostring(msg.to.id)] = nil
  save_data(_config.moderation.data, data)
     local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = nil
        save_data(_config.moderation.data, data)
      end data[tostring(groups)][tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
 if not lang then
  return "`Group` *has been removed*\n*OяƊєя Ɓу :* `"..msg.from.id.."` "
 else
  return 'گروه با موفیت از لیست گروه های مدیریتی ربات حذف شد'
end
end

 local function config_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
  print(serpent.block(data))
   for k,v in pairs(data.members_) do
   local function config_mods(arg, data)
       local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    return
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   end
tdcli_function ({
    ID = "GetUser",
    user_id_ = v.user_id_
  }, config_mods, {chat_id=arg.chat_id,user_id=v.user_id_})
 
if data.members_[k].status_.ID == "ChatMemberStatusCreator" then
owner_id = v.user_id_
   local function config_owner(arg, data)
  print(serpent.block(data))
       local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    return
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   end
tdcli_function ({
    ID = "GetUser",
    user_id_ = owner_id
  }, config_owner, {chat_id=arg.chat_id,user_id=owner_id})
   end
end
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_All group admins has been promoted and group creator is now group owner_", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_تمام ادمین های گروه به مقام مدیر منتصب شدند و سازنده گروه به مقام مالک گروه منتصب شد_", 0, "md")
     end
 end

local function filter_word(msg, word)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
if data[tostring(msg.to.id)]['filterlist'][(word)] then
   if not lang then
         return "_Word_ *"..word.."* _is already filtered_"
            else
         return "_کلمه_ *"..word.."* _از قبل فیلتر بود_"
    end
end
   data[tostring(msg.to.id)]['filterlist'][(word)] = true
     save_data(_config.moderation.data, data)
   if not lang then
         return "_Word_ *"..word.."* _added to filtered words list_"
            else
         return "_کلمه_ *"..word.."* _به لیست کلمات فیلتر شده اضافه شد_"
    end
end

local function unfilter_word(msg, word)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
      if data[tostring(msg.to.id)]['filterlist'][word] then
      data[tostring(msg.to.id)]['filterlist'][(word)] = nil
       save_data(_config.moderation.data, data)
       if not lang then
         return "_Word_ *"..word.."* _removed from filtered words list_"
       elseif lang then
         return "_کلمه_ *"..word.."* _از لیست کلمات فیلتر شده حذف شد_"
     end
      else
       if not lang then
         return "_Word_ *"..word.."* _is not filtered_"
       elseif lang then
         return "_کلمه_ *"..word.."* _از قبل فیلتر نبود_"
      end
   end
end

local function modlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.chat_id_)] then
  if not lang then
    return "_Group is not added_"
 else
    return "گروه به لیست گروه های مدیریتی ربات اضافه نشده است"
  end
 end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['mods']) == nil then --fix way
  if not lang then
    return "_No_ *moderator* _in this group_"
else
   return "در حال حاضر هیچ مدیری برای گروه انتخاب نشده است"
  end
end
if not lang then
   message = '*List of moderators :*\n'
else
   message = '*لیست مدیران گروه :*\n'
end
  for k,v in pairs(data[tostring(msg.to.id)]['mods'])
do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function ownerlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.to.id)] then
if not lang then
    return "_Group is not added_"
else
return "گروه به لیست گروه های مدیریتی ربات اضافه نشده است"
  end
end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['owners']) == nil then --fix way
 if not lang then
    return "_No_ *owner* _in this group_"
else
    return "در حال حاضر هیچ مالکی برای گروه انتخاب نشده است"
  end
end
if not lang then
   message = '*List of owners :*\n'
else
   message = '*لیست مالکین گروه :*\n'
end
  for k,v in pairs(data[tostring(msg.to.id)]['owners']) do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function action_by_reply(arg, data)
local hash = "gp_lang:"..data.chat_id_
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
if not tonumber(data.sender_user_id_) then return false end
    if data.sender_user_id_ then
  if not administration[tostring(data.chat_id_)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "_Group is not added_", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "_گروه به لیست گروه های مدیریتی ربات اضافه نشده است_", 0, "md")
     end
  end
if cmd == "setmanager" then
local function manager_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  channel_set_admin(arg.chat_id, data.id_)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now the_ *group manager*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *ادمین گروه شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, manager_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
if cmd == "remmanager" then
local function rem_manager_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  channel_demote(arg.chat_id, data.id_)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer_ *group manager*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از ادمینی گروه برکنار شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, rem_manager_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "setwhitelist" then
local function setwhitelist_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already in_ *white list*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل در لیست سفید بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been added to_ *white list*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *به لیست سفید اضافه شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, setwhitelist_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "remwhitelist" then
local function remwhitelist_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not in_ *white list*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل در لیست سفید نبود*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been removed from_ *white list*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از لیست سفید حذف شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, remwhitelist_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
if cmd == "setowner" then
local function owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *group owner*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل صاحب گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now the_ *group owner*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *به مقام صاحب گروه منتصب شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "promote" then
local function promote_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *moderator*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل مدیر گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *promoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *به مقام مدیر گروه منتصب شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, promote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
     if cmd == "remowner" then
local function rem_owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *group owner*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *از قبل صاحب گروه نبود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer a_ *group owner*", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از مقام صاحب گروه برکنار شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, rem_owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "demote" then
local function demote_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *moderator*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل مدیر گروه نبود*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *demoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از مقام مدیر گروه برکنار شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, demote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "id" then
local function id_cb(arg, data)
    return tdcli.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, id_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
else
    if lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "_کاربر یافت نشد_", 0, "md")
   else
  return tdcli.sendMessage(data.chat_id_, "", 0, "*User Not Found*", 0, "md")
      end
   end
end

local function action_by_username(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "_Group is not added_", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "_گروه به لیست گروه های مدیریتی ربات اضافه نشده است_", 0, "md")
     end
  end
if not arg.username then return false end
   if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end
if cmd == "setmanager" then
  channel_set_admin(arg.chat_id, data.id_)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now the_ *group manager*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *ادمین گروه شد*", 0, "md")
   end
end
if cmd == "remmanager" then
  channel_demote(arg.chat_id, data.id_)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer_ *group manager*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از ادمینی گروه برکنار شد*", 0, "md")
   end
 end
    if cmd == "setwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already in_ *white list*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل در لیست سفید بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been added to_ *white list*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *به لیست سفید اضافه شد*", 0, "md")
   end
end
    if cmd == "remwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not in_ *white list*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل در لیست سفید نبود*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been removed from_ *white list*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از لیست سفید حذف شد*", 0, "md")
   end
end
if cmd == "setowner" then
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *group owner*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل صاحب گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now the_ *group owner*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *به مقام صاحب گروه منتصب شد*", 0, "md")
   end
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *moderator*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل مدیر گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *promoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *به مقام مدیر گروه منتصب شد*", 0, "md")
   end
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *group owner*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *از قبل صاحب گروه نبود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer a_ *group owner*", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از مقام صاحب گروه برکنار شد*", 0, "md")
   end
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *moderator*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل مدیر گروه نبود*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *demoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از مقام مدیر گروه برکنار شد*", 0, "md")
   end
end
   if cmd == "id" then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
end
    if cmd == "res" then
    if not lang then
     text = "Result for [ "..check_markdown(data.type_.user_.username_).." ] :\n"
    .. ""..check_markdown(data.title_).."\n"
    .. " ["..data.id_.."]"
  else
     text = "اطلاعات برای [ "..check_markdown(data.type_.user_.username_).." ] :\n"
    .. "".. check_markdown(data.title_) .."\n"
    .. " [".. data.id_ .."]"
         end
       return tdcli.sendMessage(arg.chat_id, 0, 1, text, 1, 'md')
   end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر یافت نشد_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*User Not Found*", 0, "md")
      end
   end
end

local function action_by_id(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "_Group is not added_", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "_گروه به لیست گروه های مدیریتی ربات اضافه نشده است_", 0, "md")
     end
  end
if not tonumber(arg.user_id) then return false end
   if data.id_ then
if data.first_name_ then
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if cmd == "setmanager" then
  channel_set_admin(arg.chat_id, data.id_)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now the_ *group manager*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *ادمین گروه شد*", 0, "md")
   end
end
if cmd == "remmanager" then
  channel_demote(arg.chat_id, data.id_)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer_ *group manager*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از ادمینی گروه برکنار شد*", 0, "md")
   end
 end
    if cmd == "setwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already in_ *white list*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل در لیست سفید بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been added to_ *white list*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *به لیست سفید اضافه شد*", 0, "md")
   end
end
    if cmd == "remwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not in_ *white list*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل در لیست سفید نبود*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been removed from_ *white list*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از لیست سفید حذف شد*", 0, "md")
   end
end
  if cmd == "setowner" then
  if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *group owner*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل صاحب گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now the_ *group owner*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *به مقام صاحب گروه منتصب شد*", 0, "md")
   end
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *moderator*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل مدیر گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *promoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *به مقام مدیر گروه منتصب شد*", 0, "md")
   end
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *group owner*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *از قبل صاحب گروه نبود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer a_ *group owner*", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از مقام صاحب گروه برکنار شد*", 0, "md")
   end
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *moderator*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل مدیر گروه نبود*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *demoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از مقام مدیر گروه برکنار شد*", 0, "md")
   end
end
    if cmd == "whois" then
if data.username_ then
username = '@'..check_markdown(data.username_)
else
if not lang then
username = 'not found'
 else
username = 'ندارد'
  end
end
     if not lang then
       return tdcli.sendMessage(arg.chat_id, 0, 1, 'Info for [ '..data.id_..' ] :\nUserName : '..username..'\nName : '..data.first_name_, 1)
   else
       return tdcli.sendMessage(arg.chat_id, 0, 1, 'اطلاعات برای [ '..data.id_..' ] :\nیوزرنیم : '..username..'\nنام : '..data.first_name_, 1)
      end
   end
 else
    if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User not founded_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر یافت نشد_", 0, "md")
    end
  end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر یافت نشد_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*User Not Found*", 0, "md")
      end
   end
end


---------------Lock Link-------------------
local function lock_link(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_link = data[tostring(target)]["settings"]["lock_link"] 
if lock_link == "yes" then
if not lang then
 return "`Lιηк` *Ƥσѕтιηg Iѕ AƖяєαɗу Lσcкєɗ*⚠️♻️"
elseif lang then
 return "ارسال لینک در گروه هم اکنون ممنوع است⚠️♻️"
end
else
data[tostring(target)]["settings"]["lock_link"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "`Lιηк` *Ƥσѕтιηg Hαѕ Ɓєєη Lσcкєɗ*🔒\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "ارسال لینک در گروه ممنوع شد🔒\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unlock_link(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local lock_link = data[tostring(target)]["settings"]["lock_link"]
 if lock_link == "no" then
if not lang then
return "`Lιηк` *Ƥσѕтιηg Iѕ Ɲσт Lσcкєɗ*⚠️🚫" 
elseif lang then
return "ارسال لینک در گروه ممنوع نمیباشد⚠️🚫"
end
else 
data[tostring(target)]["settings"]["lock_link"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "`Lιηк` *Ƥσѕтιηg Hαѕ Ɓєєη UηƖσcкєɗ*🔓\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "ارسال لینک در گروه آزاد شد🔓\n*توسط :* `"..msg.from.id.."`"
end
end
end

---------------Lock Tag-------------------
local function lock_tag(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"] 
if lock_tag == "yes" then
if not lang then
 return "`Ƭαg` *Ƥσѕтιηg Iѕ AƖяєαɗу Lσcкєɗ*⚠️♻️"
elseif lang then
 return "ارسال تگ در گروه هم اکنون ممنوع است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["lock_tag"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "`Ƭαg` *Ƥσѕтιηg Hαѕ Ɓєєη Lσcкєɗ*🔒\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "ارسال تگ در گروه ممنوع شد🔒\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unlock_tag(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end 
end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"]
 if lock_tag == "no" then
if not lang then
return "`Ƭαg` *Ƥσѕтιηg Iѕ Ɲσт Lσcкєɗ*⚠️🚫" 
elseif lang then
return "ارسال تگ در گروه ممنوع نمیباشد⚠️🚫"
end
else 
data[tostring(target)]["settings"]["lock_tag"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "`Ƭαg` *Ƥσѕтιηg Hαѕ Ɓєєη UηƖσcкєɗ*🔓\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "ارسال تگ در گروه آزاد شد🔓\n*توسط :* `"..msg.from.id.."`"
end
end
end

---------------Lock Username-------------------
local function lock_username(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_username = data[tostring(target)]["settings"]["lock_username"] 
if lock_username == "yes" then
if not lang then
 return "`UѕєяƝαмє` *Ƥσѕтιηg Iѕ AƖяєαɗу Lσcкєɗ*⚠️♻️"
elseif lang then
 return "ارسال فحش در گروه هم اکنون ممنوع است⚠️♻️"
end
else
data[tostring(target)]["settings"]["lock_username"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "`UѕєяƝαмє` *Ƥσѕтιηg Hαѕ Ɓєєη Lσcкєɗ*🔒\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "ارسال یوزرنیم در گروه ممنوع شد🔒\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unlock_username(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local lock_username = data[tostring(target)]["settings"]["lock_username"]
 if lock_username == "no" then
if not lang then
return "`UѕєяƝαмє` *Ƥσѕтιηg Iѕ Ɲσт Lσcкєɗ*⚠️🚫" 
elseif lang then
return "ارسال یوزرنیم در گروه ممنوع نمیباشد⚠️🚫"
end
else 
data[tostring(target)]["settings"]["lock_username"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "`UѕєяƝαмє` *Ƥσѕтιηg Hαѕ Ɓєєη UηƖσcкєɗ*🔓\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "ارسال یوزرنیم در گروه آزاد شد🔓\n*توسط :* `"..msg.from.id.."`"
end
end
end

---------------Lock Mention-------------------
local function lock_mention(msg, data, target)
 local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_mention = data[tostring(target)]["settings"]["lock_mention"] 
if lock_mention == "yes" then
if not lang then
 return "`Mєηтιση` *Ƥσѕтιηg Iѕ AƖяєαɗу Lσcкєɗ*⚠️♻️"
elseif lang then
 return "ارسال فراخوانی افراد هم اکنون ممنوع است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["lock_mention"] = "yes"
save_data(_config.moderation.data, data)
if not lang then 
 return "`Mєηтιση` *Ƥσѕтιηg Hαѕ Ɓєєη Lσcкєɗ*🔒\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else 
 return "ارسال فراخوانی افراد در گروه ممنوع شد🔒\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unlock_mention(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local lock_mention = data[tostring(target)]["settings"]["lock_mention"]
 if lock_mention == "no" then
if not lang then
return "`Mєηтιση` *Ƥσѕтιηg Iѕ Ɲσт Lσcкєɗ*⚠️🚫" 
elseif lang then
return "ارسال فراخوانی افراد در گروه ممنوع نمیباشد⚠️🚫"
end
else 
data[tostring(target)]["settings"]["lock_mention"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "`Mєηтιση` *Ƥσѕтιηg Hαѕ Ɓєєη UηƖσcкєɗ*🔓\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "ارسال فراخوانی افراد در گروه آزاد شد🔓\n*توسط :* `"..msg.from.id.."`"
end
end
end

---------------Lock Arabic--------------
local function lock_arabic(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_arabic = data[tostring(target)]["settings"]["lock_arabic"] 
if lock_arabic == "yes" then
if not lang then
 return "`Aяαвιc/Ƥєяѕιαη` *Ƥσѕтιηg Iѕ AƖяєαɗу Lσcкєɗ*⚠️♻️"
elseif lang then
 return "ارسال کلمات عربی/فارسی در گروه هم اکنون ممنوع است"
end
else
data[tostring(target)]["settings"]["lock_arabic"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "`Aяαвιc/Ƥєяѕιαη` *Ƥσѕтιηg Hαѕ Ɓєєη Lσcкєɗ*🔒\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "ارسال کلمات عربی/فارسی در گروه ممنوع شد🔒\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unlock_arabic(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local lock_arabic = data[tostring(target)]["settings"]["lock_arabic"]
 if lock_arabic == "no" then
if not lang then
return "`Aяαвιc/Ƥєяѕιαη` *Ƥσѕтιηg Iѕ Ɲσт Lσcкєɗ*⚠️🚫" 
elseif lang then
return "ارسال کلمات عربی/فارسی در گروه ممنوع نمیباشد⚠️🚫"
end
else 
data[tostring(target)]["settings"]["lock_arabic"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "`Aяαвιc/Ƥєяѕιαη` *Ƥσѕтιηg Hαѕ Ɓєєη UηƖσcкєɗ*🔓\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "ارسال کلمات عربی/فارسی در گروه آزاد شد🔓\n*توسط :* `"..msg.from.id.."`"
end
end
end

---------------Lock Edit-------------------
local function lock_edit(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_edit = data[tostring(target)]["settings"]["lock_edit"] 
if lock_edit == "yes" then
if not lang then
 return "`Edιтιɴɢ` *Iѕ AƖяєαɗу Lσcкєɗ*⚠️♻️"
elseif lang then
 return "ویرایش پیام هم اکنون ممنوع است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["lock_edit"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "`Edιтιɴɢ` *Hαѕ Ɓєєη Lσcкєɗ*🔒\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "ویرایش پیام در گروه ممنوع شد🔒\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unlock_edit(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local lock_edit = data[tostring(target)]["settings"]["lock_edit"]
 if lock_edit == "no" then
if not lang then
return "`Edιтιɴɢ` *Iѕ Ɲσт Lσcкєɗ*⚠️🚫" 
elseif lang then
return "ویرایش پیام در گروه ممنوع نمیباشد⚠️🚫"
end
else 
data[tostring(target)]["settings"]["lock_edit"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "`Edιтιɴɢ` *Hαѕ Ɓєєη UηƖσcкєɗ*🔓\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "ویرایش پیام در گروه آزاد شد🔓\n*توسط :* `"..msg.from.id.."`"
end
end
end

---------------Lock spam-------------------
local function lock_spam(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_spam = data[tostring(target)]["settings"]["lock_spam"] 
if lock_spam == "yes" then
if not lang then
 return "`Sραм` *Iѕ AƖяєαɗу Lσcкєɗ*⚠️♻️"
elseif lang then
 return "ارسال هرزنامه در گروه هم اکنون ممنوع است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["lock_spam"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "`Sραм` *Hαѕ Ɓєєη Lσcкєɗ*🔒\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "ارسال هرزنامه در گروه ممنوع شد🔒\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unlock_spam(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local lock_spam = data[tostring(target)]["settings"]["lock_spam"]
 if lock_spam == "no" then
if not lang then
return "`Sραм` *Ƥσѕтιηg Iѕ Ɲσт Lσcкєɗ*⚠️🚫" 
elseif lang then
 return "ارسال هرزنامه در گروه ممنوع نمیباشد⚠️🚫"
end
else 
data[tostring(target)]["settings"]["lock_spam"] = "no" 
save_data(_config.moderation.data, data)
if not lang then 
return "`Sραм` *Ƥσѕтιηg Hαѕ Ɓєєη UηƖσcкєɗ*🔓\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
 return "ارسال هرزنامه در گروه آزاد شد🔓\n*توسط :* `"..msg.from.id.."`"
end
end
end

---------------Lock Badword-------------------
local function lock_badword(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_badword = data[tostring(target)]["settings"]["lock_badword"] 
if lock_badword == "yes" then
if not lang then
 return "`Ɓαɗωσяɗ` *Ƥσѕтιηg Iѕ AƖяєαɗу Lσcкєɗ*⚠️♻️"
elseif lang then
 return "ارسال فحش در گروه هم اکنون ممنوع است⚠️♻️"
end
else
data[tostring(target)]["settings"]["lock_badword"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "`Ɓαɗωσяɗ` *Ƥσѕтιηg Hαѕ Ɓєєη Lσcкєɗ*🔒\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "ارسال فحش در گروه ممنوع شد🔒\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unlock_badword(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local lock_badword = data[tostring(target)]["settings"]["lock_badword"]
 if lock_badword == "no" then
if not lang then
return "`Ɓαɗωσяɗ` *Ƥσѕтιηg Iѕ Ɲσт Lσcкєɗ*⚠️🚫" 
elseif lang then
return "ارسال فحش در گروه ممنوع نمیباشد⚠️🚫"
end
else 
data[tostring(target)]["settings"]["lock_badword"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "`Ɓαɗωσяɗ` *Ƥσѕтιηg Hαѕ Ɓєєη UηƖσcкєɗ*🔓\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "ارسال فحش در گروه آزاد شد🔓\n*توسط :* `"..msg.from.id.."`"
end
end
end

---------------Lock Flood-------------------
local function lock_flood(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_flood = data[tostring(target)]["settings"]["lock_flood"] 
if lock_flood == "yes" then
if not lang then
 return "`ƑƖσσɗιηg` *Iѕ AƖяєαɗу Lσcкєɗ*⚠️♻️"
elseif lang then
 return "ارسال پیام مکرر در گروه هم اکنون ممنوع است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["lock_flood"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "`ƑƖσσɗιηg` *Hαѕ Ɓєєη Lσcкєɗ*🔒\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "ارسال پیام مکرر در گروه ممنوع شد🔒\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unlock_flood(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local lock_flood = data[tostring(target)]["settings"]["lock_flood"]
 if lock_flood == "no" then
if not lang then
return "`ƑƖσσɗιηg` *Iѕ Ɲσт Lσcкєɗ*⚠️🚫" 
elseif lang then
return "ارسال پیام مکرر در گروه ممنوع نمیباشد⚠️🚫"
end
else 
data[tostring(target)]["settings"]["lock_flood"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "`ƑƖσσɗιηg` *Hαѕ Ɓєєη UηƖσcкєɗ*🔓\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "ارسال پیام مکرر در گروه آزاد شد🔓\n*توسط :* `"..msg.from.id.."`"
end
end
end

---------------Lock Bots-------------------
local function lock_bots(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"] 
if lock_bots == "yes" then
if not lang then
 return "`Ɓσтѕ` *Ƥяσтєcтιση Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "محافظت از گروه در برابر ربات ها هم اکنون فعال است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["lock_bots"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "`Ɓσтѕ` *Ƥяσтєcтιση Hαѕ Ɓєєη ƐηαвƖєɗ*🔒\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "محافظت از گروه در برابر ربات ها فعال شد🔒\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unlock_bots(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end 
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"]
 if lock_bots == "no" then
if not lang then
return "`Ɓσтѕ` *Ƥяσтєcтιση Iѕ Ɲσт Ɛηαвℓє∂*⚠️🚫" 
elseif lang then
return "محافظت از گروه در برابر ربات ها غیر فعال است⚠️🚫"
end
else 
data[tostring(target)]["settings"]["lock_bots"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "`Ɓσтѕ` *Ƥяσтєcтιση Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔓\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "محافظت از گروه در برابر ربات ها غیر فعال شد🔓\n*توسط :* `"..msg.from.id.."`"
end
end
end

---------------Lock Join-------------------
local function lock_join(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_join = data[tostring(target)]["settings"]["lock_join"] 
if lock_join == "yes" then
if not lang then
 return "`Jσιη` *Iѕ AƖяєαɗу Lσcкєɗ*⚠️♻️"
elseif lang then
 return "ورود به گروه هم اکنون ممنوع است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["lock_join"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "`Jσιη` *Hαѕ Ɓєєη Lσcкєɗ*🔒\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "ورود به گروه ممنوع شد🔒\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unlock_join(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end 
end

local lock_join = data[tostring(target)]["settings"]["lock_join"]
 if lock_join == "no" then
if not lang then
return "`Jσιη` *Iѕ Ɲσт Lσcкєɗ*⚠️🚫" 
elseif lang then
return "ورود به گروه ممنوع نمیباشد⚠️🚫"
end
else 
data[tostring(target)]["settings"]["lock_join"] = "no"
save_data(_config.moderation.data, data) 
if not lang then
return "`Jσιη` *Hαѕ Ɓєєη UηƖσcкєɗ*🔓\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "ورود به گروه آزاد شد🔓\n*توسط :* `"..msg.from.id.."`"
end
end
end

---------------Lock Tabchi-------------------
local function lock_tabchi(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_tabchi = data[tostring(target)]["settings"]["lock_tabchi"] 
if lock_tabchi == "yes" then
if not lang then
 return "`Ƭαвcнι` *Ƥσѕтιηg Iѕ AƖяєαɗу Lσcкєɗ*⚠️♻️"
elseif lang then
 return "تبچی در گروه هم اکنون ممنوع است⚠️♻️"
end
else
data[tostring(target)]["settings"]["lock_tabchi"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "`Ƭαвcнι` *Ƥσѕтιηg Hαѕ Ɓєєη Lσcкєɗ*🔒\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "تبچی در گروه ممنوع شد🔒\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unlock_tabchi(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local lock_tabchi = data[tostring(target)]["settings"]["lock_tabchi"]
 if lock_tabchi == "no" then
if not lang then
return "`Ƭαвcнι` *Ƥσѕтιηg Iѕ Ɲσт Lσcкєɗ*⚠️🚫" 
elseif lang then
return "تبچی در گروه ممنوع نمیباشد⚠️🚫"
end
else 
data[tostring(target)]["settings"]["lock_tabchi"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "`Ƭαвcнι` *Ƥσѕтιηg Hαѕ Ɓєєη UηƖσcкєɗ*🔓\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "تبچی در گروه آزاد شد🔓\n*توسط :* `"..msg.from.id.."`"
end
end
end

---------------Lock Markdown-------------------
local function lock_markdown(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"] 
if lock_markdown == "yes" then
if not lang then 
 return "`Mαякɗσωη` *Ƥσѕтιηg Iѕ AƖяєαɗу Lσcкєɗ*⚠️♻️"
elseif lang then
 return "ارسال پیام های دارای فونت در گروه هم اکنون ممنوع است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["lock_markdown"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "`Mαякɗσωη` *Ƥσѕтιηg Hαѕ Ɓєєη Lσcкєɗ*🔒\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "ارسال پیام های دارای فونت در گروه ممنوع شد🔒\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unlock_markdown(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end 
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"]
 if lock_markdown == "no" then
if not lang then
return "`Mαякɗσωη` *Ƥσѕтιηg Iѕ Ɲσт Lσcкєɗ*⚠️🚫"
elseif lang then
return "ارسال پیام های دارای فونت در گروه ممنوع نمیباشد⚠️🚫"
end
else 
data[tostring(target)]["settings"]["lock_markdown"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "`Mαякɗσωη` *Ƥσѕтιηg Hαѕ Ɓєєη UηƖσcкєɗ*🔓\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
return "ارسال پیام های دارای فونت در گروه آزاد شد🔓\n*توسط :* `"..msg.from.id.."`"
end
end
end

---------------Lock Webpage-------------------
local function lock_webpage(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"] 
if lock_webpage == "yes" then
if not lang then
 return "`Ɯєвραgє` *Iѕ AƖяєαɗу Lσcкєɗ*⚠️♻️"
elseif lang then
 return "ارسال صفحات وب در گروه هم اکنون ممنوع است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["lock_webpage"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "`Ɯєвραgє` *Hαѕ Ɓєєη Lσcкєɗ*🔒\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "ارسال صفحات وب در گروه ممنوع شد🔒\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unlock_webpage(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end 
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"]
 if lock_webpage == "no" then
if not lang then
return "`Ɯєвραgє` *Iѕ Ɲσт Lσcкєɗ*⚠️🚫" 
elseif lang then
return "ارسال صفحات وب در گروه ممنوع نمیباشد⚠️🚫"
end
else 
data[tostring(target)]["settings"]["lock_webpage"] = "no"
save_data(_config.moderation.data, data) 
if not lang then
return "`Ɯєвραgє` *Hαѕ Ɓєєη UηƖσcкєɗ*🔓\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "ارسال صفحات وب در گروه آزاد شد🔓\n*توسط :* `"..msg.from.id.."`"
end
end
end

---------------Lock English-------------------
local function lock_english(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_badword = data[tostring(target)]["settings"]["lock_english"] 
if lock_english == "yes" then
if not lang then
 return "`ƐηgƖιѕн` *Ƥσѕтιηg Iѕ AƖяєαɗу Lσcкєɗ*⚠️♻️"
elseif lang then
 return "انگلیسی در گروه هم اکنون ممنوع است⚠️♻️"
end
else
data[tostring(target)]["settings"]["lock_english"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "`ƐηgƖιѕн` *Ƥσѕтιηg Hαѕ Ɓєєη Lσcкєɗ*🔒\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "انگلیسی در گروه ممنوع شد🔒\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unlock_english(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local lock_english = data[tostring(target)]["settings"]["lock_english"]
 if lock_english == "no" then
if not lang then
return "`ƐηgƖιѕн` *Ƥσѕтιηg Iѕ Ɲσт Lσcкєɗ*⚠️🚫" 
elseif lang then
return "انگلیسی در گروه ممنوع نمیباشد⚠️🚫"
end
else 
data[tostring(target)]["settings"]["lock_english"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "`ƐηgƖιѕн` *Ƥσѕтιηg Hαѕ Ɓєєη UηƖσcкєɗ*🔓\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "انگلیسی در گروه آزاد شد🔓\n*توسط :* `"..msg.from.id.."`"
end
end
end

---------------Lock Pin-------------------
local function lock_pin(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"] 
if lock_pin == "yes" then
if not lang then
 return "`Ƥιηηєɗ Mєѕѕαgє` *Iѕ AƖяєαɗу Lσcкєɗ*⚠️♻️"
elseif lang then
 return "سنجاق کردن پیام در گروه هم اکنون ممنوع است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["lock_pin"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "`Ƥιηηєɗ Mєѕѕαgє` *Hαѕ Ɓєєη Lσcкєɗ*🔒\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "سنجاق کردن پیام در گروه ممنوع شد🔒\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unlock_pin(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end 
end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"]
 if lock_pin == "no" then
if not lang then
return "`Ƥιηηєɗ Mєѕѕαgє` *Iѕ Ɲσт Lσcкєɗ*⚠️🚫" 
elseif lang then
return "سنجاق کردن پیام در گروه ممنوع نمیباشد⚠️🚫"
end
else 
data[tostring(target)]["settings"]["lock_pin"] = "no"
save_data(_config.moderation.data, data) 
if not lang then
return "`Ƥιηηєɗ Mєѕѕαgє` *Hαѕ Ɓєєη UηƖσcкєɗ*🔓\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "سنجاق کردن پیام در گروه آزاد شد🔓\n*توسط :* `"..msg.from.id.."`"
end
end
end

--------settings---------
---------------Mute Gif-------------------
local function mute_gif(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local mute_gif = data[tostring(target)]["settings"]["mute_gif"] 
if mute_gif == "yes" then
if not lang then
 return "`Mυтє Ɠιf` *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "بیصدا کردن تصاویر متحرک فعال است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["mute_gif"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then 
 return "`Mυтє Ɠιf` *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "بیصدا کردن تصاویر متحرک فعال شد🔇\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unmute_gif(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local mute_gif = data[tostring(target)]["settings"]["mute_gif"]
 if mute_gif == "no" then
if not lang then
return "`Mυтє Ɠιf` *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫" 
elseif lang then
return "بیصدا کردن تصاویر متحرک غیر فعال بود⚠️🚫"
end
else 
data[tostring(target)]["settings"]["mute_gif"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`Mυтє Ɠιf` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "بیصدا کردن تصاویر متحرک غیر فعال شد🔊\n*توسط :* `"..msg.from.id.."`"
end
end
end
---------------Mute Game-------------------
local function mute_game(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local mute_game = data[tostring(target)]["settings"]["mute_game"] 
if mute_game == "yes" then
if not lang then
 return "`Mυтє Ɠαмє` *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "بیصدا کردن بازی های تحت وب فعال است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["mute_game"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`Mυтє Ɠαмє` *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "بیصدا کردن بازی های تحت وب فعال شد🔇\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unmute_game(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end 
end

local mute_game = data[tostring(target)]["settings"]["mute_game"]
 if mute_game == "no" then
if not lang then
return "`Mυтє Ɠαмє` *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫" 
elseif lang then
return "بیصدا کردن بازی های تحت وب غیر فعال است⚠️🚫"
end
else 
data[tostring(target)]["settings"]["mute_game"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "`Mυтє Ɠαмє` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "بیصدا کردن بازی های تحت وب غیر فعال شد🔊\n*توسط :* `"..msg.from.id.."`"
end
end
end
---------------Mute Inline-------------------
local function mute_inline(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local mute_inline = data[tostring(target)]["settings"]["mute_inline"] 
if mute_inline == "yes" then
if not lang then
 return "`Mυтє IηƖιηє` *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "بیصدا کردن کیبورد شیشه ای فعال است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["mute_inline"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`Mυтє IηƖιηє` *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "بیصدا کردن کیبورد شیشه ای فعال شد🔇\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unmute_inline(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local mute_inline = data[tostring(target)]["settings"]["mute_inline"]
 if mute_inline == "no" then
if not lang then
return "`Mυтє IηƖιηє` *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫" 
elseif lang then
return "بیصدا کردن کیبورد شیشه ای غیر فعال است⚠️🚫"
end
else 
data[tostring(target)]["settings"]["mute_inline"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`Mυтє IηƖιηє` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "بیصدا کردن کیبورد شیشه ای غیر فعال شد🔊\n*توسط :* `"..msg.from.id.."`"
end
end
end
---------------Mute Text-------------------
local function mute_text(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local mute_text = data[tostring(target)]["settings"]["mute_text"] 
if mute_text == "yes" then
if not lang then
 return "`Mυтє Ƭєxт` *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "بیصدا کردن متن فعال است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["mute_text"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`Mυтє Ƭєxт` *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "بیصدا کردن متن فعال شد🔇\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unmute_text(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end 
end

local mute_text = data[tostring(target)]["settings"]["mute_text"]
 if mute_text == "no" then
if not lang then
return "`Mυтє Ƭєxт` *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫"
elseif lang then
return "بیصدا کردن متن غیر فعال است⚠️🚫" 
end
else 
data[tostring(target)]["settings"]["mute_text"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`Mυтє Ƭєxт` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "بیصدا کردن متن غیر فعال شد🔊\n*توسط :* `"..msg.from.id.."`"
end
end
end
---------------Mute photo-------------------
local function mute_photo(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local mute_photo = data[tostring(target)]["settings"]["mute_photo"] 
if mute_photo == "yes" then
if not lang then
 return "`Mυтє Ƥнσтσ` *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "بیصدا کردن عکس فعال است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["mute_photo"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`Mυтє Ƥнσтσ` *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "بیصدا کردن عکس فعال شد🔇\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unmute_photo(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end
 
local mute_photo = data[tostring(target)]["settings"]["mute_photo"]
 if mute_photo == "no" then
if not lang then
return "`Mυтє Ƥнσтσ` *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫" 
elseif lang then
return "بیصدا کردن عکس غیر فعال است⚠️🚫"
end
else 
data[tostring(target)]["settings"]["mute_photo"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`Mυтє Ƥнσтσ` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "بیصدا کردن عکس غیر فعال شد🔊\n*توسط :* `"..msg.from.id.."`"
end
end
end
---------------Mute Video-------------------
local function mute_video(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local mute_video = data[tostring(target)]["settings"]["mute_video"] 
if mute_video == "yes" then
if not lang then
 return "`Mυтє Ʋιɗєσ` *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "بیصدا کردن فیلم فعال است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["mute_video"] = "yes" 
save_data(_config.moderation.data, data)
if not lang then 
 return "`Mυтє Ʋιɗєσ` *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "بیصدا کردن فیلم فعال شد🔇\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unmute_video(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local mute_video = data[tostring(target)]["settings"]["mute_video"]
 if mute_video == "no" then
if not lang then
return "`Mυтє Ʋιɗєσ` *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫" 
elseif lang then
return "بیصدا کردن فیلم غیر فعال است⚠️🚫"
end
else 
data[tostring(target)]["settings"]["mute_video"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`Mυтє Ʋιɗєσ` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "بیصدا کردن فیلم غیر فعال شد🔊\n*توسط :* `"..msg.from.id.."`"
end
end
end
---------------Mute Audio-------------------
local function mute_audio(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local mute_audio = data[tostring(target)]["settings"]["mute_audio"] 
if mute_audio == "yes" then
if not lang then
 return "`Mυтє Aυɗισ` *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "بیصدا کردن آهنگ فعال است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["mute_audio"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`Mυтє Aυɗισ` *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else 
return "بیصدا کردن آهنگ فعال شد🔇\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unmute_audio(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local mute_audio = data[tostring(target)]["settings"]["mute_audio"]
 if mute_audio == "no" then
if not lang then
return "`Mυтє Aυɗισ` *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫" 
elseif lang then
return "بیصدا کردن آهنک غیر فعال است⚠️🚫"
end
else 
data[tostring(target)]["settings"]["mute_audio"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "`Mυтє Aυɗισ` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
return "بیصدا کردن آهنگ غیر فعال شد🔊\n*توسط :* `"..msg.from.id.."`" 
end
end
end
---------------Mute Voice-------------------
local function mute_voice(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local mute_voice = data[tostring(target)]["settings"]["mute_voice"] 
if mute_voice == "yes" then
if not lang then
 return "`Mυтє Ʋσιcє` *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "بیصدا کردن صدا فعال است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["mute_voice"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`Mυтє Ʋσιcє` *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "بیصدا کردن صدا فعال شد🔇\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unmute_voice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local mute_voice = data[tostring(target)]["settings"]["mute_voice"]
 if mute_voice == "no" then
if not lang then
return "`Mυтє Ʋσιcє` *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫" 
elseif lang then
return "بیصدا کردن صدا غیر فعال است⚠️🚫"
end
else 
data[tostring(target)]["settings"]["mute_voice"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "`Mυтє Ʋσιcє` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "بیصدا کردن صدا غیر فعال شد🔊\n*توسط :* `"..msg.from.id.."`"
end
end
end
---------------Mute Sticker-------------------
local function mute_sticker(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local mute_sticker = data[tostring(target)]["settings"]["mute_sticker"] 
if mute_sticker == "yes" then
if not lang then
 return "`Mυтє Sтιcкєя` *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "بیصدا کردن برچسب فعال است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["mute_sticker"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`Mυтє Sтιcкєя` *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "بیصدا کردن برچسب فعال شد🔇\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unmute_sticker(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end 
end

local mute_sticker = data[tostring(target)]["settings"]["mute_sticker"]
 if mute_sticker == "no" then
if not lang then
return "`Mυтє Sтιcкєя` *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫" 
elseif lang then
return "بیصدا کردن برچسب غیر فعال است⚠️🚫"
end
else 
data[tostring(target)]["settings"]["mute_sticker"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "`Mυтє Sтιcкєя` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
return "بیصدا کردن برچسب غیر فعال شد🔊\n*توسط :* `"..msg.from.id.."`"
end 
end
end
---------------Mute Contact-------------------
local function mute_contact(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local mute_contact = data[tostring(target)]["settings"]["mute_contact"] 
if mute_contact == "yes" then
if not lang then
 return "`Mυтє Ƈσηтαcт` *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "بیصدا کردن مخاطب فعال است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["mute_contact"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`Mυтє Ƈσηтαcт` *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "بیصدا کردن مخاطب فعال شد🔇\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unmute_contact(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local mute_contact = data[tostring(target)]["settings"]["mute_contact"]
 if mute_contact == "no" then
if not lang then
return "`Mυтє Ƈσηтαcт` *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫" 
elseif lang then
return "بیصدا کردن مخاطب غیر فعال است⚠️🚫"
end
else 
data[tostring(target)]["settings"]["mute_contact"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`Mυтє Ƈσηтαcт` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "بیصدا کردن مخاطب غیر فعال شد🔊\n*توسط :* `"..msg.from.id.."`"
end
end
end
---------------Mute Forward-------------------
local function mute_forward(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local mute_forward = data[tostring(target)]["settings"]["mute_forward"] 
if mute_forward == "yes" then
if not lang then
 return "`Mυтє Ƒσяωαяɗ` *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "بیصدا کردن نقل قول فعال است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["mute_forward"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`Mυтє Ƒσяωαяɗ` *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "بیصدا کردن نقل قول فعال شد🔇\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unmute_forward(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local mute_forward = data[tostring(target)]["settings"]["mute_forward"]
 if mute_forward == "no" then
if not lang then
return "`Mυтє Ƒσяωαяɗ` *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫"
elseif lang then
return "بیصدا کردن نقل قول غیر فعال است⚠️🚫"
end 
else 
data[tostring(target)]["settings"]["mute_forward"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "`Mυтє Ƒσяωαяɗ` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "بیصدا کردن نقل قول غیر فعال شد🔊\n*توسط :* `"..msg.from.id.."`"
end
end
end
---------------Mute Location-------------------
local function mute_location(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local mute_location = data[tostring(target)]["settings"]["mute_location"] 
if mute_location == "yes" then
if not lang then
 return "`Mυтє Lσcαтιση` *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "بیصدا کردن موقعیت فعال است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["mute_location"] = "yes" 
save_data(_config.moderation.data, data)
if not lang then
 return "`Mυтє Lσcαтιση` *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "بیصدا کردن موقعیت فعال شد🔇\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unmute_location(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local mute_location = data[tostring(target)]["settings"]["mute_location"]
 if mute_location == "no" then
if not lang then
return "`Mυтє Lσcαтιση` *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫" 
elseif lang then
return "بیصدا کردن موقعیت غیر فعال است⚠️🚫"
end
else 
data[tostring(target)]["settings"]["mute_location"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`Mυтє Lσcαтιση` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "بیصدا کردن موقعیت غیر فعال شد🔊\n*توسط :* `"..msg.from.id.."`"
end
end
end
---------------Mute Document-------------------
local function mute_document(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end

local mute_document = data[tostring(target)]["settings"]["mute_document"] 
if mute_document == "yes" then
if not lang then
 return "`Mυтє Ɗσcυмєηт` *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "بیصدا کردن اسناد فعال لست⚠️♻️"
end
else
 data[tostring(target)]["settings"]["mute_document"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`Mυтє Ɗσcυмєηт` *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "بیصدا کردن اسناد فعال شد🔇\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unmute_document(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local mute_document = data[tostring(target)]["settings"]["mute_document"]
 if mute_document == "no" then
if not lang then
return "`Mυтє Ɗσcυмєηт` *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫" 
elseif lang then
return "بیصدا کردن اسناد غیر فعال است⚠️🚫"
end
else 
data[tostring(target)]["settings"]["mute_document"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`Mυтє Ɗσcυмєηт` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "بیصدا کردن اسناد غیر فعال شد🔊\n*توسط :* `"..msg.from.id.."`"
end
end
end
---------------Mute TgService-------------------
local function mute_tgservice(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local mute_tgservice = data[tostring(target)]["settings"]["mute_tgservice"] 
if mute_tgservice == "yes" then
if not lang then
 return "`Mυтє ƬgSєяνιcє` *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "بیصدا کردن خدمات تلگرام فعال است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["mute_tgservice"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`Mυтє ƬgSєяνιcє` *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
return "بیصدا کردن خدمات تلگرام فعال شد🔇\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unmute_tgservice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نیستید"
end 
end

local mute_tgservice = data[tostring(target)]["settings"]["mute_tgservice"]
 if mute_tgservice == "no" then
if not lang then
return "`Mυтє ƬgSєяνιcє` *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫"
elseif lang then
return "بیصدا کردن خدمات تلگرام غیر فعال است⚠️🚫"
end 
else 
data[tostring(target)]["settings"]["mute_tgservice"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`Mυтє ƬgSєяνιcє` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
return "بیصدا کردن خدمات تلگرام غیر فعال شد🔊\n*توسط :* `"..msg.from.id.."`"
end 
end
end

---------------Mute Keyboard-------------------
local function mute_keyboard(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local mute_keyboard = data[tostring(target)]["settings"]["mute_keyboard"] 
if mute_keyboard == "yes" then
if not lang then
 return "`Mυтє Ƙєувσαяɗ` *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "بیصدا کردن صفحه کلید فعال است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["mute_keyboard"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`Mυтє Ƙєувσαяɗ` *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
return "بیصدا کردن صفحه کلید فعال شد🔇\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unmute_keyboard(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نیستید"
end 
end

local mute_keyboard = data[tostring(target)]["settings"]["mute_keyboard"]
 if mute_keyboard == "no" then
if not lang then
return "`Mυтє Ƙєувσαяɗ` *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫"
elseif lang then
return "بیصدا کردن صفحه کلید غیرفعال است⚠️🚫"
end 
else 
data[tostring(target)]["settings"]["mute_keyboard"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`Mυтє Ƙєувσαяɗ` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
return "بیصدا کردن صفحه کلید غیرفعال شد🔊\n*توسط :* `"..msg.from.id.."`"
end 
end
end

function group_settings(msg, target) 	
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
local target = msg.to.id 
if not is_mod(msg) then
if not lang then
 	return "_You're Not_ *Moderator*"
else
  return "شما مدیر گروه نمیباشید"
end
end
local data = load_data(_config.moderation.data)
local target = msg.to.id 
if data[tostring(target)] then 	
if data[tostring(target)]["settings"]["num_msg_max"] then 	
NUM_MSG_MAX = tonumber(data[tostring(target)]['settings']['num_msg_max'])
	print('custom'..NUM_MSG_MAX) 	
else 	
NUM_MSG_MAX = 5
end
if data[tostring(target)]["settings"]["set_char"] then 	
SETCHAR = tonumber(data[tostring(target)]['settings']['set_char'])
	print('custom'..SETCHAR) 	
else 	
SETCHAR = 40
end
if data[tostring(target)]["settings"]["time_check"] then 	
TIME_CHECK = tonumber(data[tostring(target)]['settings']['time_check'])
	print('custom'..TIME_CHECK) 	
else 	
TIME_CHECK = 2
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_link"] then			
data[tostring(target)]["settings"]["lock_link"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_tag"] then			
data[tostring(target)]["settings"]["lock_tag"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_username"] then			
data[tostring(target)]["settings"]["lock_username"] = "yes"		
end
end


if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_mention"] then			
data[tostring(target)]["settings"]["lock_mention"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_arabic"] then			
data[tostring(target)]["settings"]["lock_arabic"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_edit"] then			
data[tostring(target)]["settings"]["lock_edit"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_spam"] then			
data[tostring(target)]["settings"]["lock_spam"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_english"] then			
data[tostring(target)]["settings"]["lock_english"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_flood"] then			
data[tostring(target)]["settings"]["lock_flood"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_bots"] then			
data[tostring(target)]["settings"]["lock_bots"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_markdown"] then			
data[tostring(target)]["settings"]["lock_markdown"] = "no"		
end
end

 if data[tostring(target)]["settings"] then		
 if not data[tostring(target)]["settings"]["lock_badword"] then			
 data[tostring(target)]["settings"]["lock_badword"] = "no"		
 end
 end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_webpage"] then			
data[tostring(target)]["settings"]["lock_webpage"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_tabchi"] then			
data[tostring(target)]["settings"]["lock_tabchi"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["welcome"] then			
data[tostring(target)]["settings"]["welcome"] = "no"		
end
end

 if data[tostring(target)]["settings"] then		
 if not data[tostring(target)]["settings"]["lock_pin"] then			
 data[tostring(target)]["settings"]["lock_pin"] = "no"		
 end
 end
if data[tostring(target)]["settings"] then		
 if not data[tostring(target)]["settings"]["lock_join"] then			
 data[tostring(target)]["settings"]["lock_join"] = "no"		
 end
 end
 if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_gif"] then			
data[tostring(target)]["settings"]["mute_gif"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_text"] then			
data[tostring(target)]["settings"]["mute_text"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_photo"] then			
data[tostring(target)]["settings"]["mute_photo"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_video"] then			
data[tostring(target)]["settings"]["mute_video"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_audio"] then			
data[tostring(target)]["settings"]["mute_audio"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_voice"] then			
data[tostring(target)]["settings"]["mute_voice"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_sticker"] then			
data[tostring(target)]["settings"]["mute_sticker"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_contact"] then			
data[tostring(target)]["settings"]["mute_contact"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_forward"] then			
data[tostring(target)]["settings"]["mute_forward"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_location"] then			
data[tostring(target)]["settings"]["mute_location"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_document"] then			
data[tostring(target)]["settings"]["mute_document"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_tgservice"] then			
data[tostring(target)]["settings"]["mute_tgservice"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_inline"] then			
data[tostring(target)]["settings"]["mute_inline"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_game"] then			
data[tostring(target)]["settings"]["mute_game"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_keyboard"] then			
data[tostring(target)]["settings"]["mute_keyboard"] = "no"		
end
end
 local expire_date = ''
local expi = redis:ttl('ExpireDate:'..msg.to.id)
if expi == -1 then
if lang then
	expire_date = 'نامحدود!'
else
	expire_date = 'Unlimited!'
end
else
	local day = math.floor(expi / 86400) + 1
if lang then
	expire_date = day..' روز'
else
	expire_date = day..' Days'
end
end
local cmdss = redis:hget('group:'..msg.to.id..':cmd', 'bot')
	local cmdsss = ''
	if lang then
	if cmdss == 'owner' then
	cmdsss = cmdsss..'اونر و بالاتر'
	elseif cmdss == 'moderator' then
	cmdsss = cmdsss..'مدیر و بالاتر'
	else
	cmdsss = cmdsss..'کاربر و بالاتر'
	end
	else
	if cmdss == 'owner' then
	cmdsss = cmdsss..'Owner or higher'
	elseif cmdss == 'moderator' then
	cmdsss = cmdsss..'Moderator or higher'
	else
	cmdsss = cmdsss..'Member or higher'
	end
	end
local hash = "muteall:"..msg.to.id
local check_time = redis:ttl(hash)
day = math.floor(check_time / 86400)
bday = check_time % 86400
hours = math.floor( bday / 3600)
bhours = bday % 3600
min = math.floor(bhours / 60)
sec = math.floor(bhours % 60)
if not lang then
if not redis:get(hash) or check_time == -1 then
 mute_all1 = 'no'
elseif tonumber(check_time) > 1 and check_time < 60 then
 mute_all1 = '_enable for_ *'..sec..'* _sec_'
elseif tonumber(check_time) > 60 and check_time < 3600 then
 mute_all1 = '_enable for_ '..min..' _min_ *'..sec..'* _sec_'
elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
 mute_all1 = '_enable for_ *'..hours..'* _hour_ *'..min..'* _min_ *'..sec..'* _sec_'
elseif tonumber(check_time) > 86400 then
 mute_all1 = '_enable for_ *'..day..'* _day_ *'..hours..'* _hour_ *'..min..'* _min_ *'..sec..'* _sec_'
 end
elseif lang then
if not redis:get(hash) or check_time == -1 then
 mute_all2 = '*no*'
elseif tonumber(check_time) > 1 and check_time < 60 then
 mute_all2 = '_فعال برای_ *'..sec..'* _ثانیه_'
elseif tonumber(check_time) > 60 and check_time < 3600 then
 mute_all2 = '_فعال برای_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانیه_'
elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
 mute_all2 = '_فعال برای_ *'..hours..'* _ساعت و_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانیه_'
elseif tonumber(check_time) > 86400 then
 mute_all2 = '_فعال برای_ *'..day..'* _روز و_ *'..hours..'* _ساعت و_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانیه_'
 end
end
if not lang then
local settings = data[tostring(target)]["settings"] 
text = "*̅G̅ʀ̅օ̅ʊ̅ք̅ ̅S̅ɛ̅ȶ̅ȶ̅ɨ̅ռ̅ɢ̅ֆ:*\n*̅ʟ̅օ̅ƈ̅ӄ̅ ̅ɛ̅ɖ̅ɨ̅ȶ:* "..settings.lock_edit.."\n*̅ʟ̅օ̅ƈ̅ӄ̅ ̅ʟ̅ɨ̅ռ̅ӄ̅ֆ :* "..settings.lock_link.."\n*̅ʟ̅օ̅ƈ̅ӄ̅ ̅ȶ̅ǟ̅ɢ̅ֆ :* "..settings.lock_tag.."\n*̅ʟ̅օ̅ƈ̅ӄ̅ ̅ʝ̅օ̅ɨ̅ռ :* "..settings.lock_join.."\n*̅ʟ̅օ̅ƈ̅ӄ̅ ̅ʄ̅ʟ̅օ̅օ̅ɖ :* "..settings.lock_flood.."\n*̅ʟ̅օ̅ƈ̅ӄ̅ ̅ʊ̅ֆ̅ɛ̅ʀ̅ռ̅ǟ̅ʍ̅ɛ :* "..settings.lock_username.."\n*̅ʟ̅օ̅ƈ̅ӄ̅ ̅ֆ̅ք̅ǟ̅ʍ :* "..settings.lock_spam.."\n*̅ʟ̅օ̅ƈ̅ӄ̅ ̅ʍ̅ɛ̅ռ̅ȶ̅ɨ̅օ̅ռ :* "..settings.lock_mention.."\n*̅ʟ̅օ̅ƈ̅ӄ̅ ̅ɛ̅ռ̅ɢ̅ʟ̅ɨ̅ֆ̅ɦ :* "..settings.lock_english.."\n*̅ʟ̅օ̅ƈ̅ӄ̅ ̅ǟ̅ʀ̅ǟ̅ɮ̅ɨ̅ƈ: :* "..settings.lock_arabic.."\n*̅ʟ̅օ̅ƈ̅ӄ̅ ̅ա̅ɛ̅ɮ̅ք̅ǟ̅ɢ̅ɛ :* "..settings.lock_webpage.."\n*̅ʟ̅օ̅ƈ̅ӄ̅ ̅ɮ̅ǟ̅ɖ̅ա̅օ̅ʀ̅ɖ :* "..settings.lock_badword.."\n*̅ʟ̅օ̅ƈ̅ӄ̅ ̅ʍ̅ǟ̅ʀ̅ӄ̅ɖ̅օ̅ա̅ռ :* "..settings.lock_markdown.."\n*̅ʟ̅օ̅ƈ̅ӄ̅ ̅ȶ̅ǟ̅ɮ̅ƈ̅ɦ̅ɨ :* "..settings.lock_tabchi.."\n*̅G̅ʀ̅օ̅ʊ̅ք̅ ̅ա̅ɛ̅ʟ̅ƈ̅օ̅ʍ̅ɛ :* "..settings.welcome.."\n*̅L̅օ̅ƈ̅ӄ̅ ̅ք̅ɨ̅ռ̅ ̅ʍ̅ɛ̅ֆ̅ֆ̅ǟ̅ɢ̅ɛ :* "..settings.lock_pin.."\n*̅B̅օ̅ȶ̅ֆ̅ ̅ք̅ʀ̅օ̅ȶ̅ɛ̅ƈ̅ȶ̅ɨ̅օ̅ռ :* "..settings.lock_bots.."\n*̅F̅ʟ̅օ̅օ̅ɖ̅ ̅ֆ̅ɛ̅ռ̅ֆ̅ɨ̅ȶ̅ɨ̅ʋ̅ɨ̅ȶ̅ʏ :* *"..NUM_MSG_MAX.."*\n*̅C̅ɦ̅ǟ̅ʀ̅ǟ̅ƈ̅ȶ̅ɛ̅ʀ̅ ̅ֆ̅ɛ̅ռ̅ֆ̅ɨ̅ȶ̅ɨ̅ʋ̅ɨ̅ȶ̅ʏ :* *"..SETCHAR.."*\n*̅F̅ℓ̅σ̅σ̅đ̅ ̅ƈ̅ɧ̅ε̅ƈ̅ҡ̅ ̅ŧ̅ï̅ɱ̅ε :* *"..TIME_CHECK.."*\n➖➖➖➖➖➖➖➖➖\n*̅G̅ŗ̅σ̅ų̅þ̅ ̅M̅ų̅ŧ̅ε̅ ̅L̅ï̅ş̅ŧ* : \n*̅M̅ų̅ŧ̅ε̅ ̅ɠ̅ï̅∱ :* "..settings.mute_gif.."\n*̅M̅ų̅ŧ̅ε̅ ̅ŧ̅ε̅х̅ŧ :* "..settings.mute_text.."\n*̅M̅ų̅ŧ̅ε̅ ̅ï̅ŋ̅ℓ̅ï̅ŋ̅ε :* "..settings.mute_inline.."\n*̅M̅ų̅ŧ̅ε̅ ̅ɠ̅ą̅ɱ̅ε :* "..settings.mute_game.."\n*̅M̅ų̅ŧ̅ε̅ ̅þ̅ɧ̅σ̅ŧ̅σ :* "..settings.mute_photo.."\n*̅M̅ų̅ŧ̅ε̅ ̅√̅ï̅đ̅ε̅σ :* "..settings.mute_video.."\n*̅M̅ų̅ŧ̅ε̅ ̅ą̅ų̅đ̅ï̅σ :* "..settings.mute_audio.."\n*̅M̅ų̅ŧ̅ε̅ ̅√̅σ̅ï̅ƈ̅ε :* "..settings.mute_voice.."\n*̅M̅ų̅ŧ̅ε̅ ̅ş̅ŧ̅ï̅ƈ̅ҡ̅ε̅ŗ :* "..settings.mute_sticker.."\n*̅M̅ų̅ŧ̅ε̅ ̅ƈ̅σ̅ŋ̅ŧ̅ą̅ƈ̅ŧ :* "..settings.mute_contact.."\n*̅M̅ų̅ŧ̅ε̅ ̅∱̅σ̅ŗ̅щ̅ą̅ŗ̅đ :* "..settings.mute_forward.."\n*̅M̅ų̅ŧ̅ε̅ ̅ℓ̅σ̅ƈ̅ą̅ŧ̅ï̅σ̅ŋ :* "..settings.mute_location.."\n*̅M̅ų̅ŧ̅ε̅ ̅đ̅σ̅ƈ̅ų̅ɱ̅ε̅ŋ̅ŧ :* "..settings.mute_document.."\n*̅M̅ų̅ŧ̅ε̅ ̅T̅ɠ̅S̅ε̅ŗ̅√̅ï̅ƈ̅ε :* "..settings.mute_tgservice.."\n*̅M̅ų̅ŧ̅ε̅ ̅K̅ε̅γ̅ɓ̅σ̅ą̅ŗ̅đ :* "..settings.mute_keyboard.."\n*̅M̅ų̅ŧ̅ε̅ ̅A̅ℓ̅ℓ :* "..mute_all1.."\n➖➖➖➖➖➖➖➖➖\n*̅E̅х̅þ̅ï̅ŗ̅ε̅ ̅D̅ą̅ŧ̅ε :* *"..expire_date.."*\n*̅B̅σ̅ŧ̅ ̅C̅σ̅ɱ̅ɱ̅ą̅ŋ̅đ̅ş :* *"..cmdsss.."*\n*̅B̅σ̅ŧ̅ ̅ƈ̅ɧ̅ą̅ŋ̅ŋ̅ε̅ℓ:* @ProtectionTeam\n*̅G̅ŗ̅σ̅ų̅þ̅ ̅L̅ą̅ŋ̅ɠ̅ų̅ą̅ɠ̅ε:* *̅E̅N*"
else
local settings = data[tostring(target)]["settings"] 
 text = "*تنظیمات گروه:*\n_قفل ویرایش پیام :_ "..settings.lock_edit.."\n_قفل لینک :_ "..settings.lock_link.."\n_قفل ورود :_ "..settings.lock_join.."\n_قفل تگ :_ "..settings.lock_tag.."\n_قفل پیام مکرر :_ "..settings.lock_flood.."\n_قفل یوزرنیم :_ "..settings.lock_username.."\n_قفل هرزنامه :_ "..settings.lock_spam.."\n_قفل فراخوانی :_ "..settings.lock_mention.."\n_قفل انگلیسی :_ "..settings.lock_english.."\n_قفل عربی :_ "..settings.lock_arabic.."\n_قفل صفحات وب :_ "..settings.lock_webpage.."\n_قفل فحش :_ "..settings.lock_badword.."\n_قفل فونت :_ "..settings.lock_markdown.."\n_قفل تبچی :_ "..settings.lock_tabchi.."\n_پیام خوشآمد گویی :_ "..settings.welcome.."\n_قفل سنجاق کردن :_ "..settings.lock_pin.."\n_محافظت در برابر ربات ها :_ "..settings.lock_bots.."\n_حداکثر پیام مکرر :_ *"..NUM_MSG_MAX.."*\n_حداکثر حروف مجاز :_ *"..SETCHAR.."*\n_زمان بررسی پیام های مکرر :_ *"..TIME_CHECK.."*\n➖➖➖➖➖➖➖➖➖\n*لیست بیصدا ها* : \n_بیصدا تصاویر متحرک :_ "..settings.mute_gif.."\n_بیصدا متن :_ "..settings.mute_text.."\n_بیصدا کیبورد شیشه ای :_ "..settings.mute_inline.."\n_بیصدا بازی های تحت وب :_ "..settings.mute_game.."\n_بیصدا عکس :_ "..settings.mute_photo.."\n_بیصدا فیلم :_ "..settings.mute_video.."\n_بیصدا آهنگ :_ "..settings.mute_audio.."\n_بیصدا صدا :_ "..settings.mute_voice.."\n_بیصدا برچسب :_ "..settings.mute_sticker.."\n_بیصدا مخاطب :_ "..settings.mute_contact.."\n_بیصدا نقل قول :_ "..settings.mute_forward.."\n_بیصدا موقعیت :_ "..settings.mute_location.."\n_بیصدا اسناد :_ "..settings.mute_document.."\n_بیصدا خدمات تلگرام :_ "..settings.mute_tgservice.."\n_بیصدا صفحه کلید :_ "..settings.mute_keyboard.."\n_بیصدا همه پیام ها :_ "..mute_all2.."\n*____________________*\n_دستورات ربات :_ *"..cmdsss.."*\n_تاریخ انقضا :_ *"..expire_date.."*\n*کانال ربات*: @ProtectionTeam\n_زبان سوپر گروه :_ `فارسی`"
end
text = string.gsub(text, 'yes', '🔒')
text = string.gsub(text, 'no', '🔓')
return text
end


local function run(msg, matches)
if is_banned(msg.from.id, msg.to.id) or is_gbanned(msg.from.id, msg.to.id) or is_silent_user(msg.from.id, msg.to.id) then
return false
end
local cmd = redis:hget('group:'..msg.to.id..':cmd', 'bot')
local mutealll = redis:get('group:'..msg.to.id..':muteall')
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
local chat = msg.to.id
local user = msg.from.id
if cmd == 'moderator' and not is_mod(msg) or cmd == 'owner' and not is_owner(msg) or mutealll and not is_mod(msg) then
 return 
 else
if msg.to.type ~= 'pv' then
if matches[1]:lower() == "id" or matches[1] == 'ایدی' then
if not matches[2] and not msg.reply_id then
local function getpro(arg, data)
   if data.photos_[0] then
       if not lang then
            tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'Chat ID : '..msg.to.id..'\nUser ID : '..msg.from.id,dl_cb,nil)
       elseif lang then
          tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'شناسه گروه : '..msg.to.id..'\nشناسه شما : '..msg.from.id,dl_cb,nil)
     end
   else
       if not lang then
      tdcli.sendMessage(msg.to.id, msg.id_, 1, "`You Have Not Profile Photo...!`\n\n> *Chat ID :* `"..msg.to.id.."`\n*User ID :* `"..msg.from.id.."`", 1, 'md')
       elseif lang then
      tdcli.sendMessage(msg.to.id, msg.id_, 1, "_شما هیچ عکسی ندارید...!_\n\n> _شناسه گروه :_ `"..msg.to.id.."`\n_شناسه شما :_ `"..msg.from.id.."`", 1, 'md')
            end
        end
   end
   tdcli_function ({
    ID = "GetUserProfilePhotos",
    user_id_ = msg.from.id,
    offset_ = 0,
    limit_ = 1
  }, getpro, nil)
end
if msg.reply_id and not matches[2] then
tdcli.getMessage(msg.to.id, msg.reply_id, action_by_reply, {chat_id=msg.to.id,cmd="id"})
  end
if matches[2] and #matches[2] > 3 and not matches[3] then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="id"})
      end
   end
if (matches[1]:lower() == "pin" or matches[1] == 'سنجاق') and is_mod(msg) and msg.reply_id then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == 'yes' then
if is_owner(msg) then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1)
if not lang then
return "*Message Has Been Pinned*"
elseif lang then
return "پیام سجاق شد"
end
elseif not is_owner(msg) then
   return
 end
 elseif lock_pin == 'no' then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1)
if not lang then
return "*Message Has Been Pinned*"
elseif lang then
return "پیام سجاق شد"
end
end
end
if (matches[1]:lower() == 'unpin' or matches[1] == 'حذف سنجاق') and is_mod(msg) then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == 'yes' then
if is_owner(msg) then
tdcli.unpinChannelMessage(msg.to.id)
if not lang then
return "*Pin message has been unpinned*"
elseif lang then
return "پیام سنجاق شده پاک شد"
end
elseif not is_owner(msg) then
   return 
 end
 elseif lock_pin == 'no' then
tdcli.unpinChannelMessage(msg.to.id)
if not lang then
return "*Pin message has been unpinned*"
elseif lang then
return "پیام سنجاق شده پاک شد"
end
end
end
if matches[1]:lower() == "add" or matches[1] == 'افزودن' then
return modadd(msg)
end
if matches[1]:lower() == "rem" or matches[1] == 'حذف گروه' then
return modrem(msg)
end
if (matches[1]:lower() == "setmanager" or matches[1] == 'ادمین گروه') and is_owner(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setmanager"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="setmanager"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="setmanager"})
      end
   end
if (matches[1]:lower() == "remmanager" or matches[1] == 'حذف ادمین گروه') and is_owner(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="remmanager"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="remmanager"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="remmanager"})
      end
   end
if (matches[1]:lower() == "whitelist" or matches[1] == 'لیست سفید') and matches[2] == "+" and is_mod(msg) then
if not matches[3] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setwhitelist"})
  end
  if matches[3] and string.match(matches[3], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[3],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[3],cmd="setwhitelist"})
    end
  if matches[3] and not string.match(matches[3], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[3]
    }, action_by_username, {chat_id=msg.to.id,username=matches[3],cmd="setwhitelist"})
      end
   end
if (matches[1]:lower() == "whitelist" or matches[1] == 'لیست سفید') and matches[2] == "-" and is_mod(msg) then
if not matches[3] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="remwhitelist"})
  end
  if matches[3] and string.match(matches[3], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[3],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[3],cmd="remwhitelist"})
    end
  if matches[3] and not string.match(matches[3], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[3]
    }, action_by_username, {chat_id=msg.to.id,username=matches[3],cmd="remwhitelist"})
      end
   end
if (matches[1]:lower() == "setowner" or matches[1] == 'مالک') and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="setowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="setowner"})
      end
   end
if (matches[1]:lower() == "remowner" or matches[1] == 'حذف مالک') and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="remowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="remowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="remowner"})
      end
   end
if (matches[1]:lower() == "promote" or matches[1] == 'مدیر') and is_owner(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="promote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="promote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="promote"})
      end
   end
if (matches[1]:lower() == "demote" or matches[1] == 'حذف مدیر') and is_owner(msg) then
if not matches[2] and msg.reply_id then
 tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="demote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="demote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="demote"})
      end
   end
if (matches[1]:lower() == "lock" or matches[1] == 'قفل') and is_mod(msg) then
local target = msg.to.id
if not lang then
if matches[2] == "link" then
return lock_link(msg, data, target)
end
if matches[2] == "tag" then
return lock_tag(msg, data, target)
end
if matches[2] == 'username' then
return lock_username(msg, data, target)
end
if matches[2] == "mention" then
return lock_mention(msg, data, target)
end
if matches[2] == "arabic" then
return lock_arabic(msg, data, target)
end
if matches[2] == 'english' then
return lock_english(msg, data, target)
end
if matches[2] == "edit" then
return lock_edit(msg, data, target)
end
if matches[2] == "spam" then
return lock_spam(msg, data, target)
end
if matches[2] == "flood" then
return lock_flood(msg, data, target)
end
if matches[2] == 'tabchi' then
return lock_tabchi(msg, data, target)
end
if matches[2] == "bots" then
return lock_bots(msg, data, target)
end
if matches[2] == "markdown" then
return lock_markdown(msg, data, target)
end
if matches[2] == "webpage" then
return lock_webpage(msg, data, target)
end
if matches[2] == 'badword' then
return lock_badword(msg, data, target)
end
if matches[2] == "pin" and is_owner(msg) then
return lock_pin(msg, data, target)
end
if matches[2] == "join" then
return lock_join(msg, data, target)
end
if matches[2] == 'cmds' then
			redis:hset('group:'..msg.to.id..':cmd', 'bot', 'moderator')
			return 'cmds has been locked for member'
			end
else
if matches[2] == 'لینک' then
return lock_link(msg, data, target)
end
if matches[2] == 'تگ' then
return lock_tag(msg, data, target)
end
if matches[2] == 'یوزرنیم' then
return lock_username(msg, data, target)
end
if matches[2] == 'فراخوانی' then
return lock_mention(msg, data, target)
end
if matches[2] == 'عربی' then
return lock_arabic(msg, data, target)
end
if matches[2] == 'انگلیسی' then
return lock_english(msg, data, target)
end
if matches[2] == 'ویرایش' then
return lock_edit(msg, data, target)
end
if matches[2] == 'هرزنامه' then
return lock_spam(msg, data, target)
end
if matches[2] == 'پیام مکرر' then
return lock_flood(msg, data, target)
end
if matches[2] == 'تبچی' then
return lock_tabchi(msg, data, target)
end
if matches[2] == 'ربات' then
return lock_bots(msg, data, target)
end
if matches[2] == 'فونت' then
return lock_markdown(msg, data, target)
end
if matches[2] == 'وب' then
return lock_webpage(msg, data, target)
end
if matches[2] == 'فحش' then
return lock_badword(msg, data, target)
end
if matches[2] == 'سنجاق' and is_owner(msg) then
return lock_pin(msg, data, target)
end
if matches[2] == "ورود" then
return lock_join(msg, data, target)
end
if matches[2] == 'دستورات' then
			redis:hset('group:'..msg.to.id..':cmd', 'bot', 'moderator')
			return 'دستورات برای کاربر عادی قفل شد'
			end
			end
end
if (matches[1]:lower() == "unlock" or matches[1] == 'باز') and is_mod(msg) then
local target = msg.to.id
if not lang then
if matches[2] == "link" then
return unlock_link(msg, data, target)
end
if matches[2] == "tag" then
return unlock_tag(msg, data, target)
end
if matches[2] == 'username' then
return unlock_username(msg, data, target)
end
if matches[2] == "mention" then
return unlock_mention(msg, data, target)
end
if matches[2] == "arabic" then
return unlock_arabic(msg, data, target)
end
if matches[2] == 'english' then
return unlock_english(msg, data, target)
end
if matches[2] == "edit" then
return unlock_edit(msg, data, target)
end
if matches[2] == "spam" then
return unlock_spam(msg, data, target)
end
if matches[2] == "flood" then
return unlock_flood(msg, data, target)
end
if matches[2] == 'tabchi' then
return unlock_tabchi(msg, data, target)
end
if matches[2] == "bots" then
return unlock_bots(msg, data, target)
end
if matches[2] == "markdown" then
return unlock_markdown(msg, data, target)
end
if matches[2] == "webpage" then
return unlock_webpage(msg, data, target)
end
if matches[2] == 'badword' then
return unlock_badword(msg, data, target)
end
if matches[2] == "pin" and is_owner(msg) then
return unlock_pin(msg, data, target)
end
if matches[2] == "join" then
return unlock_join(msg, data, target)
end
if matches[2] == 'cmds' then
			redis:del('group:'..msg.to.id..':cmd')
			return 'cmds has been unlocked for member'
			end
	else
if matches[2] == 'لینک' then
return unlock_link(msg, data, target)
end
if matches[2] == 'تگ' then
return unlock_tag(msg, data, target)
end
if matches[2] == 'یوزرنیم' then
return unlock_username(msg, data, target)
end
if matches[2] == 'فراخوانی' then
return unlock_mention(msg, data, target)
end
if matches[2] == 'عربی' then
return unlock_arabic(msg, data, target)
end
if matches[2] == 'انگلیسی' then
return unlock_english(msg, data, target)
end
if matches[2] == 'ویرایش' then
return unlock_edit(msg, data, target)
end
if matches[2] == 'هرزنامه' then
return unlock_spam(msg, data, target)
end
if matches[2] == 'پیام مکرر' then
return unlock_flood(msg, data, target)
end
if matches[2] == 'تبچی' then
return unlock_tabchi(msg, data, target)
end
if matches[2] == 'ربات' then
return unlock_bots(msg, data, target)
end
if matches[2] == 'فونت' then
return unlock_markdown(msg, data, target)
end
if matches[2] == 'وب' then
return unlock_webpage(msg, data, target)
end
if matches[2] == 'فحش' then
return unlock_badword(msg, data, target)
end
if matches[2] == 'سنجاق' and is_owner(msg) then
return unlock_pin(msg, data, target)
end
if matches[2] == "ورود" then
return unlock_join(msg, data, target)
end
if matches[2] == 'دستورات' then
			redis:del('group:'..msg.to.id..':cmd')
			return 'دستورات برای کاربر عادی باز شد'
			end
	end
end
if (matches[1]:lower() == "mute" or matches[1] == 'بیصدا') and is_mod(msg) then
local target = msg.to.id
if not lang then
if matches[2] == "gif" then
return mute_gif(msg, data, target)
end
if matches[2] == "text" then
return mute_text(msg ,data, target)
end
if matches[2] == "photo" then
return mute_photo(msg ,data, target)
end
if matches[2] == "video" then
return mute_video(msg ,data, target)
end
if matches[2] == "audio" then
return mute_audio(msg ,data, target)
end
if matches[2] == "voice" then
return mute_voice(msg ,data, target)
end
if matches[2] == "sticker" then
return mute_sticker(msg ,data, target)
end
if matches[2] == "contact" then
return mute_contact(msg ,data, target)
end
if matches[2] == "forward" then
return mute_forward(msg ,data, target)
end
if matches[2] == "location" then
return mute_location(msg ,data, target)
end
if matches[2] == "document" then
return mute_document(msg ,data, target)
end
if matches[2] == "tgservice" then
return mute_tgservice(msg ,data, target)
end
if matches[2] == "inline" then
return mute_inline(msg ,data, target)
end
if matches[2] == "game" then
return mute_game(msg ,data, target)
end
if matches[2] == "keyboard" then
return mute_keyboard(msg ,data, target)
end
if matches[2] == 'all' then
local hash = 'muteall:'..msg.to.id
redis:set(hash, true)
return "*Mute All* *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
end
else
if matches[2] == 'تصاویر متحرک' then
return mute_gif(msg, data, target)
end
if matches[2] == 'متن' then
return mute_text(msg ,data, target)
end
if matches[2] == 'عکس' then
return mute_photo(msg ,data, target)
end
if matches[2] == 'فیلم' then
return mute_video(msg ,data, target)
end
if matches[2] == 'اهنگ' then
return mute_audio(msg ,data, target)
end
if matches[2] == 'صدا' then
return mute_voice(msg ,data, target)
end
if matches[2] == 'برچسب' then
return mute_sticker(msg ,data, target)
end
if matches[2] == 'مخاطب' then
return mute_contact(msg ,data, target)
end
if matches[2] == 'نقل قول' then
return mute_forward(msg ,data, target)
end
if matches[2] == 'موقعیت' then
return mute_location(msg ,data, target)
end
if matches[2] == 'اسناد' then
return mute_document(msg ,data, target)
end
if matches[2] == 'خدمات تلگرام' then
return mute_tgservice(msg ,data, target)
end
if matches[2] == 'کیبورد شیشه ای' then
return mute_inline(msg ,data, target)
end
if matches[2] == 'بازی' then
return mute_game(msg ,data, target)
end
if matches[2] == 'صفحه کلید' then
return mute_keyboard(msg ,data, target)
end
if matches[2]== 'همه' then
local hash = 'muteall:'..msg.to.id
redis:set(hash, true)
return "بیصدا کردن گروه فعال شد"
end
end
end
if (matches[1]:lower() == "unmute" or matches[1] == 'باصدا') and is_mod(msg) then
local target = msg.to.id
if not lang then
if matches[2] == "gif" then
return unmute_gif(msg, data, target)
end
if matches[2] == "text" then
return unmute_text(msg, data, target)
end
if matches[2] == "photo" then
return unmute_photo(msg ,data, target)
end
if matches[2] == "video" then
return unmute_video(msg ,data, target)
end
if matches[2] == "audio" then
return unmute_audio(msg ,data, target)
end
if matches[2] == "voice" then
return unmute_voice(msg ,data, target)
end
if matches[2] == "sticker" then
return unmute_sticker(msg ,data, target)
end
if matches[2] == "contact" then
return unmute_contact(msg ,data, target)
end
if matches[2] == "forward" then
return unmute_forward(msg ,data, target)
end
if matches[2] == "location" then
return unmute_location(msg ,data, target)
end
if matches[2] == "document" then
return unmute_document(msg ,data, target)
end
if matches[2] == "tgservice" then
return unmute_tgservice(msg ,data, target)
end
if matches[2] == "inline" then
return unmute_inline(msg ,data, target)
end
if matches[2] == "game" then
return unmute_game(msg ,data, target)
end
if matches[2] == "keyboard" then
return unmute_keyboard(msg ,data, target)
end
 if matches[2] == 'all' then
         local hash = 'muteall:'..msg.to.id
        redis:del(hash)
          return "*Mute All* *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
end
else
if matches[2] == 'تصاویر متحرک' then
return unmute_gif(msg, data, target)
end
if matches[2] == 'متن' then
return unmute_text(msg, data, target)
end
if matches[2] == 'عکس' then
return unmute_photo(msg ,data, target)
end
if matches[2] == 'فیلم' then
return unmute_video(msg ,data, target)
end
if matches[2] == 'اهنگ' then
return unmute_audio(msg ,data, target)
end
if matches[2] == 'صدا' then
return unmute_voice(msg ,data, target)
end
if matches[2] == 'برچسب' then
return unmute_sticker(msg ,data, target)
end
if matches[2] == 'مخاطب' then
return unmute_contact(msg ,data, target)
end
if matches[2] == 'نقل قول' then
return unmute_forward(msg ,data, target)
end
if matches[2] == 'موقعیت' then
return unmute_location(msg ,data, target)
end
if matches[2] == 'اسناد' then
return unmute_document(msg ,data, target)
end
if matches[2] == 'خدمات تلگرام' then
return unmute_tgservice(msg ,data, target)
end
if matches[2] == 'کیبورد شیشه ای' then
return unmute_inline(msg ,data, target)
end
if matches[2] == 'بازی' then
return unmute_game(msg ,data, target)
end
if matches[2] == 'صفحه کلید' then
return unmute_keyboard(msg ,data, target)
end
 if matches[2]=='همه' and is_mod(msg) then
         local hash = 'muteall:'..msg.to.id
        redis:del(hash)
          return "گروه ازاد شد و افراد می توانند دوباره پست بگذارند"
		  
end
end
end
if (matches[1]:lower() == 'cmds' or matches[1] == 'دستورات') and is_owner(msg) then 
	if not lang then
		if matches[2]:lower() == 'owner' then 
		redis:hset('group:'..msg.to.id..':cmd', 'bot', 'owner') 
		return 'cmds set for owner or higher' 
		end
		if matches[2]:lower() == 'moderator' then 
		redis:hset('group:'..msg.to.id..':cmd', 'bot', 'moderator')
		return 'cmds set for moderator or higher'
		end 
		if matches[2]:lower() == 'member' then 
		redis:hset('group:'..msg.to.id..':cmd', 'bot', 'member') 
		return 'cmds set for member or higher' 
		end 
	else
		if matches[2] == 'مالک' then 
		redis:hset('group:'..msg.to.id..':cmd', 'bot', 'owner') 
		return 'دستورات برای مدیرکل به بالا دیگر جواب می دهد' 
		end
		if matches[2] == 'مدیر' then 
		redis:hset('group:'..msg.to.id..':cmd', 'bot', 'moderator')
		return 'دستورات برای مدیر به بالا دیگر جواب می دهد' 
		end 
		if matches[2] == 'کاربر' then 
		redis:hset('group:'..msg.to.id..':cmd', 'bot', 'member') 
		return 'دستورات برای کاربر عادی به بالا دیگر جواب می دهد' 
		end 
		end
	end
if (matches[1]:lower() == "gpinfo" or matches[1] == 'اطلاعات گروه') and is_mod(msg) and msg.to.type == "channel" then
local function group_info(arg, data)
if not lang then
ginfo = "*Group Info :*\n_Admin Count :_ *"..data.administrator_count_.."*\n_Member Count :_ *"..data.member_count_.."*\n_Kicked Count :_ *"..data.kicked_count_.."*\n_Group ID :_ *"..data.channel_.id_.."*"
elseif lang then
ginfo = "*اطلاعات گروه :*\n_تعداد مدیران :_ *"..data.administrator_count_.."*\n_تعداد اعضا :_ *"..data.member_count_.."*\n_تعداد اعضای حذف شده :_ *"..data.kicked_count_.."*\n_شناسه گروه :_ *"..data.channel_.id_.."*"
end
        tdcli.sendMessage(arg.chat_id, arg.msg_id, 1, ginfo, 1, 'md')
end
 tdcli.getChannelFull(msg.to.id, group_info, {chat_id=msg.to.id,msg_id=msg.id})
end
if (matches[1]:lower() == 'newlink' or matches[1] == 'لینک جدید') and is_mod(msg) and not matches[2] then
	local function callback_link (arg, data)
    local administration = load_data(_config.moderation.data) 
				if not data.invite_link_ then
					administration[tostring(msg.to.id)]['settings']['linkgp'] = nil
					save_data(_config.moderation.data, administration)
       if not lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_Bot is not group creator_\n_set a link for group with using_ /setlink", 1, 'md')
       elseif lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_ربات سازنده گروه نیست_\n_با دستور_ setlink/ _لینک جدیدی برای گروه ثبت کنید_", 1, 'md')
    end
				else
					administration[tostring(msg.to.id)]['settings']['linkgp'] = data.invite_link_
					save_data(_config.moderation.data, administration)
        if not lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "*Newlink Created*", 1, 'md')
        elseif lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_لینک جدید ساخته شد_", 1, 'md')
            end
				end
			end
 tdcli.exportChatInviteLink(msg.to.id, callback_link, nil)
		end
		if (matches[1]:lower() == 'newlink' or matches[1] == 'لینک جدید') and is_mod(msg) and (matches[2] == 'pv' or matches[2] == 'خصوصی') then
	local function callback_link (arg, data)
		local result = data.invite_link_
		local administration = load_data(_config.moderation.data) 
				if not result then
					administration[tostring(msg.to.id)]['settings']['linkgp'] = nil
					save_data(_config.moderation.data, administration)
       if not lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_Bot is not group creator_\n_set a link for group with using_ /setlink", 1, 'md')
       elseif lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_ربات سازنده گروه نیست_\n_با دستور_ setlink/ _لینک جدیدی برای گروه ثبت کنید_", 1, 'md')
    end
				else
					administration[tostring(msg.to.id)]['settings']['linkgp'] = result
					save_data(_config.moderation.data, administration)
        if not lang then
		tdcli.sendMessage(user, msg.id, 1, "*Newlink Group* _:_ `"..msg.to.id.."`\n"..result, 1, 'md')
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "*New link Was Send In Your Private Message*", 1, 'md')
        elseif lang then
		tdcli.sendMessage(user, msg.id, 1, "*لینک جدید گروه* _:_ `"..msg.to.id.."`\n"..result, 1, 'md')
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_لینک جدید ساخته شد و در پیوی شما ارسال شد_", 1, 'md')
            end
				end
			end
 tdcli.exportChatInviteLink(msg.to.id, callback_link, nil)
		end
		if (matches[1]:lower() == 'setlink' or matches[1] == 'تنظیم لینک') and is_owner(msg) then
		if not matches[2] then
		data[tostring(chat)]['settings']['linkgp'] = 'waiting'
			save_data(_config.moderation.data, data)
			if not lang then
			return '_Please send the new group_ *link* _now_'
    else 
         return 'لطفا لینک گروه خود را ارسال کنید'
       end
	   end
		 data[tostring(chat)]['settings']['linkgp'] = matches[2]
			 save_data(_config.moderation.data, data)
      if not lang then
			return '_Group Link Was Saved Successfully._'
    else 
         return 'لینک گروه شما با موفقیت ذخیره شد'
       end
		end
		if msg.text then
   local is_link = msg.text:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") or msg.text:match("^([https?://w]*.?t.me/joinchat/%S+)$")
			if is_link and data[tostring(chat)]['settings']['linkgp'] == 'waiting' and is_owner(msg) then
				data[tostring(chat)]['settings']['linkgp'] = msg.text
				save_data(_config.moderation.data, data)
            if not lang then
				return "*Newlink* _has been set_"
           else
           return "لینک جدید ذخیره شد"
		 	end
       end
		end
    if (matches[1]:lower() == 'link' or matches[1] == 'لینک') and is_mod(msg) and not matches[2] then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
      if not lang then
        return "_First create a link for group with using_ /newlink\n_If bot not group creator set a link with using_ /setlink"
     else
        return "ابتدا با دستور newlink/ لینک جدیدی برای گروه بسازید\nو اگر ربات سازنده گروه نیس با دستور setlink/ لینک جدیدی برای گروه ثبت کنید"
      end
      end
     if not lang then
       text = "<b>Group Link :</b>\n"..linkgp
     else
      text = "<b>لینک گروه :</b>\n"..linkgp
         end
        return tdcli.sendMessage(chat, msg.id, 1, text, 1, 'html')
     end
    if (matches[1]:lower() == 'link' or matches[1] == 'لینک') and (matches[2] == 'pv' or matches[2] == 'خصوصی') then
	if is_mod(msg) then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
      if not lang then
        return "_First create a link for group with using_ /newlink\n_If bot not group creator set a link with using_ /setlink"
     else
        return "ابتدا با دستور newlink/ لینک جدیدی برای گروه بسازید\nو اگر ربات سازنده گروه نیس با دستور setlink/ لینک جدیدی برای گروه ثبت کنید"
      end
      end
     if not lang then
	 tdcli.sendMessage(chat, msg.id, 1, "<b>link Was Send In Your Private Message</b>", 1, 'html')
     tdcli.sendMessage(user, "", 1, "<b>Group Link "..msg.to.title.." :</b>\n"..linkgp, 1, 'html')
     else
	 tdcli.sendMessage(chat, msg.id, 1, "<b>لینک گروه در پیوی  شما ارسال شد</b>", 1, 'html')
      tdcli.sendMessage(user, "", 1, "<b>لینک گروه "..msg.to.title.." :</b>\n"..linkgp, 1, 'html')
         end
     end
	 end
  if (matches[1]:lower() == "setrules" or matches[1] == 'تنظیم قوانین') and matches[2] and is_mod(msg) then
    data[tostring(chat)]['rules'] = matches[2]
	  save_data(_config.moderation.data, data)
     if not lang then
    return "*Group rules* _has been set_"
   else 
  return "قوانین گروه ثبت شد"
   end
  end
  if matches[1]:lower() == "rules" or matches[1] == 'قوانین' then
 if not data[tostring(chat)]['rules'] then
   if not lang then
     rules = "ℹ️ The Default Rules :\n1⃣ No Flood.\n2⃣ No Spam.\n3⃣ No Advertising.\n4⃣ Try to stay on topic.\n5⃣ Forbidden any racist, sexual, homophobic or gore content.\n➡️ Repeated failure to comply with these rules will cause ban.\n@ProtectionTeam"
    elseif lang then
       rules = "ℹ️ قوانین پپیشفرض:\n1⃣ ارسال پیام مکرر ممنوع.\n2⃣ اسپم ممنوع.\n3⃣ تبلیغ ممنوع.\n4⃣ سعی کنید از موضوع خارج نشید.\n5⃣ هرنوع نژاد پرستی, شاخ بازی و پورنوگرافی ممنوع .\n➡️ از قوانین پیروی کنید, در صورت عدم رعایت قوانین اول اخطار و در صورت تکرار مسدود.\n@ProtectionTeam"
 end
        else
     rules = "*Group Rules :*\n"..data[tostring(chat)]['rules']
      end
    return rules
  end
if (matches[1]:lower() == "res" or matches[1] == 'کاربری') and matches[2] and is_mod(msg) then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="res"})
  end
if (matches[1]:lower() == "whois" or matches[1] == 'شناسه') and matches[2] and string.match(matches[2], '^%d+$') and is_mod(msg) then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="whois"})
  end
		if matches[1]:lower() == 'setchar' or matches[1]:lower() == 'حداکثر حروف مجاز' then
			if not is_mod(msg) then
				return
			end
			local chars_max = matches[2]
			data[tostring(msg.to.id)]['settings']['set_char'] = chars_max
			save_data(_config.moderation.data, data)
    if not lang then
     return "*Character sensitivity* _has been set to :_ *[ "..matches[2].." ]*"
   else
     return "_حداکثر حروف مجاز در پیام تنظیم شد به :_ *[ "..matches[2].." ]*"
		end
  end
  if (matches[1]:lower() == 'setflood' or matches[1] == 'تنظیم پیام مکرر') and is_mod(msg) then
			if tonumber(matches[2]) < 1 or tonumber(matches[2]) > 50 then
				return "_Wrong number, range is_ *[2-50]*"
      end
			local flood_max = matches[2]
			data[tostring(chat)]['settings']['num_msg_max'] = flood_max
			save_data(_config.moderation.data, data)
			if not lang then
    return "_Group_ *flood* _sensitivity has been set to :_ *[ "..matches[2].." ]*"
    else
    return '_محدودیت پیام مکرر به_ *'..tonumber(matches[2])..'* _تنظیم شد._'
    end
       end
  if (matches[1]:lower() == 'setfloodtime' or matches[1] == 'تنظیم زمان بررسی') and is_mod(msg) then
			if tonumber(matches[2]) < 2 or tonumber(matches[2]) > 10 then
				return "_Wrong number, range is_ *[2-10]*"
      end
			local time_max = matches[2]
			data[tostring(chat)]['settings']['time_check'] = time_max
			save_data(_config.moderation.data, data)
			if not lang then
    return "_Group_ *flood* _check time has been set to :_ *[ "..matches[2].." ]*"
    else
    return "_حداکثر زمان بررسی پیام های مکرر تنظیم شد به :_ *[ "..matches[2].." ]*"
    end
       end
		if (matches[1]:lower() == 'clean' or matches[1] == 'پاک کردن') and is_owner(msg) then
		if not lang then
			if matches[2] == 'mods' then
				if next(data[tostring(chat)]['mods']) == nil then
					return "_No_ *moderators* _in this group_"
            end
				for k,v in pairs(data[tostring(chat)]['mods']) do
					data[tostring(chat)]['mods'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
				return "_All_ *moderators* _has been demoted_"
         end
			if matches[2] == 'filterlist' then
				if next(data[tostring(chat)]['filterlist']) == nil then
					return "*Filtered words list* _is empty_"
				end
				for k,v in pairs(data[tostring(chat)]['filterlist']) do
					data[tostring(chat)]['filterlist'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
				return "*Filtered words list* _has been cleaned_"
			end
			if matches[2] == 'rules' then
				if not data[tostring(chat)]['rules'] then
					return "_No_ *rules* _available_"
				end
					data[tostring(chat)]['rules'] = nil
					save_data(_config.moderation.data, data)
				return "*Group rules* _has been cleaned_"
       end
			if matches[2] == 'welcome' then
				if not data[tostring(chat)]['setwelcome'] then
					return "*Welcome Message not set*"
				end
					data[tostring(chat)]['setwelcome'] = nil
					save_data(_config.moderation.data, data)
				return "*Welcome message* _has been cleaned_"
       end
			if matches[2] == 'about' then
        if msg.to.type == "chat" then
				if not data[tostring(chat)]['about'] then
					return "_No_ *description* _available_"
				end
					data[tostring(chat)]['about'] = nil
					save_data(_config.moderation.data, data)
        elseif msg.to.type == "channel" then
   tdcli.changeChannelAbout(chat, "", dl_cb, nil)
             end
				return "*Group description* _has been cleaned_"
		   	end
			else
			if matches[2] == 'مدیران' then
				if next(data[tostring(chat)]['mods']) == nil then
                return "هیچ مدیری برای گروه انتخاب نشده است"
            end
				for k,v in pairs(data[tostring(chat)]['mods']) do
					data[tostring(chat)]['mods'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
            return "تمام مدیران گروه تنزیل مقام شدند"
         end
			if matches[2] == 'لیست فیلتر' then
				if next(data[tostring(chat)]['filterlist']) == nil then
					return "_لیست کلمات فیلتر شده خالی است_"
				end
				for k,v in pairs(data[tostring(chat)]['filterlist']) do
					data[tostring(chat)]['filterlist'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
				return "_لیست کلمات فیلتر شده پاک شد_"
			end
			if matches[2] == 'قوانین' then
				if not data[tostring(chat)]['rules'] then
               return "قوانین برای گروه ثبت نشده است"
				end
					data[tostring(chat)]['rules'] = nil
					save_data(_config.moderation.data, data)
            return "قوانین گروه پاک شد"
       end
			if matches[2] == 'خوشآمد' then
				if not data[tostring(chat)]['setwelcome'] then
               return "پیام خوشآمد گویی ثبت نشده است"
				end
					data[tostring(chat)]['setwelcome'] = nil
					save_data(_config.moderation.data, data)
            return "پیام خوشآمد گویی پاک شد"
       end
			if matches[2] == 'درباره' then
        if msg.to.type == "chat" then
				if not data[tostring(chat)]['about'] then
              return "پیامی مبنی بر درباره گروه ثبت نشده است"
				end
					data[tostring(chat)]['about'] = nil
					save_data(_config.moderation.data, data)
        elseif msg.to.type == "channel" then
   tdcli.changeChannelAbout(chat, "", dl_cb, nil)
             end
              return "پیام مبنی بر درباره گروه پاک شد"
		   	end
			
			end
        end
		if (matches[1]:lower() == 'clean' or matches[1] == 'پاک کردن') and is_admin(msg) then
		if not lang then
			if matches[2] == 'owners' then
				if next(data[tostring(chat)]['owners']) == nil then
					return "_No_ *owners* _in this group_"
				end
				for k,v in pairs(data[tostring(chat)]['owners']) do
					data[tostring(chat)]['owners'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
				return "_All_ *owners* _has been demoted_"
			end
			else
			if matches[2] == 'مالکان' then
				if next(data[tostring(chat)]['owners']) == nil then
                return "مالکی برای گروه انتخاب نشده است"
				end
				for k,v in pairs(data[tostring(chat)]['owners']) do
					data[tostring(chat)]['owners'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
            return "تمامی مالکان گروه تنزیل مقام شدند"
			end
			end
     end
if (matches[1]:lower() == "setname" or matches[1] == 'تنظیم نام') and matches[2] and is_mod(msg) then
local gp_name = matches[2]
tdcli.changeChatTitle(chat, gp_name, dl_cb, nil)
end
  if (matches[1]:lower() == "setabout" or matches[1] == 'تنظیم درباره') and matches[2] and is_mod(msg) then
     if msg.to.type == "channel" then
   tdcli.changeChannelAbout(chat, matches[2], dl_cb, nil)
    elseif msg.to.type == "chat" then
    data[tostring(chat)]['about'] = matches[2]
	  save_data(_config.moderation.data, data)
     end
     if not lang then
    return "*Group description* _has been set_"
    else
     return "پیام مبنی بر درباره گروه ثبت شد"
      end
  end
  if matches[1]:lower() == "about" or matches[1] == 'درباره' and msg.to.type == "chat" then
 if not data[tostring(chat)]['about'] then
     if not lang then
     about = "_No_ *description* _available_"
      elseif lang then
      about = "پیامی مبنی بر درباره گروه ثبت نشده است"
       end
        else
     about = "*Group Description :*\n"..data[tostring(chat)]['about']
      end
    return about
  end
  if (matches[1]:lower() == 'filter' or matches[1] == 'فیلتر') and is_mod(msg) then
    return filter_word(msg, matches[2])
  end
  if (matches[1]:lower() == 'unfilter' or matches[1] == 'حذف فیلتر') and is_mod(msg) then
    return unfilter_word(msg, matches[2])
  end
  if (matches[1]:lower() == 'config' or matches[1] == 'پیکربندی') and is_admin(msg) then
tdcli.getChannelMembers(msg.to.id, 0, 'Administrators', 200, config_cb, {chat_id=msg.to.id})
  end
  if (matches[1]:lower() == 'filterlist' or matches[1] == 'لیست فیلتر') and is_mod(msg) then
    return filter_list(msg)
  end
if (matches[1]:lower() == "modlist" or matches[1] == 'لیست مدیران') and is_mod(msg) then
return modlist(msg)
end
if (matches[1]:lower() == "whitelist" or matches[1] == 'لیست سفید') and not matches[2] and is_mod(msg) then
return whitelist(msg.to.id)
end
if (matches[1]:lower() == "ownerlist" or matches[1] == 'لیست مالکان') and is_owner(msg) then
return ownerlist(msg)
end
if (matches[1]:lower() == "settings" or matches[1] == 'تنظیمات') and is_mod(msg) then
return group_settings(msg, target)
end
if matches[1]:lower() == "setlang" and is_owner(msg) then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if matches[2] == "fa" then
redis:set(hash, true)
return "*زبان گروه تنظیم شد به : فارسی*"..BDRpm
end
end
if matches[1] == 'زبان انگلیسی' then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 redis:del(hash)
return "_Group Language Set To:_ EN"..BDRpm
end
 if (matches[1] == 'mutetime' or matches[1] == 'زمان بیصدا') and is_mod(msg) then
local hash = 'muteall:'..msg.to.id
local hour = tonumber(matches[2])
local num1 = (tonumber(hour) * 3600)
local minutes = tonumber(matches[3])
local num2 = (tonumber(minutes) * 60)
local second = tonumber(matches[4])
local num3 = tonumber(second) 
local num4 = tonumber(num1 + num2 + num3)
redis:setex(hash, num4, true)
if not lang then
 return "_Mute all has been enabled for_ \n⏺ *hours :* `"..matches[2].."`\n⏺ *minutes :* `"..matches[3].."`\n⏺ *seconds :* `"..matches[4].."`"..BDRpm
 elseif lang then
 return "بی صدا کردن فعال شد در \n⏺ ساعت : "..matches[2].."\n⏺ دقیقه : "..matches[3].."\n⏺ ثانیه : "..matches[4]..BDRpm
 end
 end
 if (matches[1] == 'mutehours' or matches[1]== 'ساعت بیصدا') and is_mod(msg) then
       local hash = 'muteall:'..msg.to.id
local hour = matches[2]
local num1 = tonumber(hour) * 3600
local num4 = tonumber(num1)
redis:setex(hash, num4, true)
if not lang then
 return "Mute all has been enabled for \n⏺ hours : "..matches[2]..BDRpm
 elseif lang then
 return "بی صدا کردن فعال شد در \n⏺ ساعت : "..matches[2]..BDRpm
 end
 end
  if (matches[1] == 'muteminutes' or matches[1]== 'دقیقه بیصدا')  and is_mod(msg) then
 local hash = 'muteall:'..msg.to.id
local minutes = matches[2]
local num2 = tonumber(minutes) * 60
local num4 = tonumber(num2)
redis:setex(hash, num4, true)
if not lang then
 return "Mute all has been enabled for \n⏺ minutes : "..matches[2]..BDRpm
 elseif lang then
 return "بی صدا کردن فعال شد در \n⏺ دقیقه : "..matches[2]..BDRpm
 end
 end
  if (matches[1] == 'settingseconds' or matches[1] == 'ثانیه بیصدا') and is_mod(msg) then
       local hash = 'muteall:'..msg.to.id
local second = matches[2]
local num3 = tonumber(second) 
local num4 = tonumber(num3)
redis:setex(hash, num3, true)
if not lang then
 return "Mute all has been enabled for \n⏺ seconds : "..matches[2]..BDRpm
 elseif lang then
 return "بی صدا کردن فعال شد در \n⏺ ثانیه : "..matches[2]..BDRpm
 end
 end
 if (matches[1] == 'muteall' or matches[1] == 'موقعیت') and (matches[2] == 'status' or matches[2] == 'بیصدا') and is_mod(msg) then
         local hash = 'muteall:'..msg.to.id
      local mute_time = redis:ttl(hash)
		
		if tonumber(mute_time) < 0 then
		if not lang then
		return '_Mute All is Disable._'
		else
		return '_بیصدا بودن گروه غیر فعال است._'
		end
		else
		if not lang then
          return mute_time.." Sec"
		  elseif lang then
		  return mute_time.."ثانیه"
		end
		end
  end
-------------Edit--------------
if matches[1] == 'edit' or matches[1] == 'ادیت' and msg.reply_to_message_id_ ~= 0 and is_sudo(msg) then
local text = matches[2]
tdcli.editMessageText(msg.to.id, msg.reply_to_message_id_, nil, text, 1, 'md')
end

if matches[1] == 'edit' or matches[1] == 'ادیت' and msg.reply_to_message_id_ ~= 0 and is_sudo(msg) then
local tExt = matches[2]
tdcli.editMessageCaption(msg.to.id, msg.reply_to_message_id_, nil, tExt)
end
--------------Plugin----------------
  local function plugin_enabled( name )
  for k,v in pairs(_config.enabled_plugins) do
    if name == v then
      return k
    end
  end
  -- If not found
  return false
end

-- Returns true if file exists in plugins folder
local function plugin_exists( name )
  for k,v in pairs(plugins_names()) do
    if name..'.lua' == v then
      return true
    end
  end
  return false
end

local function list_all_plugins(only_enabled, msg)
  local tmp = '\nt.me/ProtectionTeam'
  local text = ''
  local nsum = 0
  for k, v in pairs( plugins_names( )) do
    --  ✔ enabled, ❌ disabled
    local status = '➖-»'
    nsum = nsum+1
    nact = 0
    -- Check if is enabled
    for k2, v2 in pairs(_config.enabled_plugins) do
      if v == v2..'.lua' then 
        status = '➕-»'
      end
      nact = nact+1
    end
    if not only_enabled or status == '➕-»'then
      -- get the name
      v = string.match (v, "(.*)%.lua")
      text = text..nsum..'.'..status..' '..v..' \n'
    end
  end
  text = '<code>'..text..'</code>\n\n'..nsum..' <b>📂plugins installed</b>\n\n'..nact..' <i>➕️plugins enabled</i>\n\n'..nsum-nact..' <i>➖plugins disabled</i>'..tmp
  tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'html')
end

local function list_plugins(only_enabled, msg)
  local text = ''
  local nsum = 0
  for k, v in pairs( plugins_names( )) do
    --  ✔ enabled, ❌ disabled
    local status = '*➖-»*'
    nsum = nsum+1
    nact = 0
    -- Check if is enabled
    for k2, v2 in pairs(_config.enabled_plugins) do
      if v == v2..'.lua' then 
        status = '*|➕|-»*'
      end
      nact = nact+1
    end
    if not only_enabled or status == '*➕-»*'then
      -- get the name
      v = string.match (v, "(.*)%.lua")
     -- text = text..v..'  '..status..'\n'
    end
  end
  text = "*BotReloaded :|*"
  tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'md')
end

local function reload_plugins(checks, msg)
  plugins = {}
  load_plugins()
  return list_plugins(true, msg)
end


local function enable_plugin( plugin_name, msg )
  print('checking if '..plugin_name..' exists')
  -- Check if plugin is enabled
  if plugin_enabled(plugin_name) then
    local text = '<b>'..plugin_name..'</b> <i>is enabled.</i>'
	tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'html')
	return
  end
  -- Checks if plugin exists
  if plugin_exists(plugin_name) then
    -- Add to the config table
    table.insert(_config.enabled_plugins, plugin_name)
    print(plugin_name..' added to _config table')
    save_config()
    -- Reload the plugins
    return reload_plugins(true, msg)
  else
    local text = '<b>'..plugin_name..'</b> <i>does not exists.</i>'
	tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'html')
  end
end

local function disable_plugin( name, msg )
  local k = plugin_enabled(name)
  -- Check if plugin is enabled
  if not k then
    local text = '<b>'..name..'</b> <i>not enabled.</i>'
	tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'html')
	return
  end
  -- Check if plugins exists
  if not plugin_exists(name) then
    local text = '<b>'..name..'</b> <i>does not exists.</i>'
	tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'html')
  else
  -- Disable and reload
  table.remove(_config.enabled_plugins, k)
  save_config( )
  return reload_plugins(true, msg)
end  
end

local function disable_plugin_on_chat(receiver, plugin, msg)
  if not plugin_exists(plugin) then
    return "_Plugin doesn't exists_"
  end

  if not _config.disabled_plugin_on_chat then
    _config.disabled_plugin_on_chat = {}
  end

  if not _config.disabled_plugin_on_chat[receiver] then
    _config.disabled_plugin_on_chat[receiver] = {}
  end

  _config.disabled_plugin_on_chat[receiver][plugin] = true

  save_config()
  local text = '<b>'..plugin..'</b> <i>disabled on this chat.</i>'
  tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'html')
end

local function reenable_plugin_on_chat(receiver, plugin, msg)
  if not _config.disabled_plugin_on_chat then
    return 'There aren\'t any disabled plugins'
  end

  if not _config.disabled_plugin_on_chat[receiver] then
    return 'There aren\'t any disabled plugins for this chat'
  end

  if not _config.disabled_plugin_on_chat[receiver][plugin] then
    return '_This plugin is not disabled_'
  end

  _config.disabled_plugin_on_chat[receiver][plugin] = false
  save_config()
  local text = '<b>'..plugin..'</b> <i>is enabled again.</i>'
  tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'html')
end

  -- Show the available plugins 
  if is_sudo(msg) then
  if (matches[1]:lower() == 'plugin' or matches[1] == 'لیست پلاگین') then --after changed to moderator mode, set only sudo
    return list_all_plugins(false, msg)
  end
  -- Re-enable a plugin for this chat
   if matches[1]:lower() == 'pl' or matches[1] == 'پلاگین' then
  if matches[2] == '+' and matches[4] == 'chat' or matches[4] == 'گروه' then
      if is_mod(msg) then
    local receiver = msg.chat_id_
    local plugin = matches[3]
    print("enable "..plugin..' on this chat')
    return reenable_plugin_on_chat(receiver, plugin, msg)
  end
    end

  -- Enable a plugin
  if matches[2] == '+' and is_sudo(msg) then --after changed to moderator mode, set only sudo
    local plugin_name = matches[3]
    print("enable: "..matches[3])
    return enable_plugin(plugin_name, msg)
  end
  -- Disable a plugin on a chat
  if matches[2] == '-' and matches[4] == 'chat' or matches[4] == 'گروه' then
      if is_mod(msg) then
    local plugin = matches[3]
    local receiver = msg.chat_id_
    print("disable "..plugin..' on this chat')
    return disable_plugin_on_chat(receiver, plugin, msg)
  end
    end
  -- Disable a plugin
  if matches[2] == '-' and is_sudo(msg) then --after changed to moderator mode, set only sudo
    if matches[3] == 'plugins' then
		return 'This plugin can\'t be disabled'
    end
    print("disable: "..matches[3])
    return disable_plugin(matches[3], msg)
  end

  -- Reload all the plugins!
  if matches[2] == '*' and is_sudo(msg) then --after changed to moderator mode, set only sudo
    return reload_plugins(true, msg)
  end
  end
  if (matches[1]:lower() == 'reload' or matches[1] == 'بارگذاری') and is_sudo(msg) then --after changed to moderator mode, set only sudo
    return reload_plugins(true, msg)
  end
end
--------------------Me---------------------
local function setrank(msg, user_id, value,chat_id)
  local hash = nil

    hash = 'rank:'..msg.to.id..':variables'

  if hash then
    redis:hset(hash, user_id, value)
  return tdcli.sendMessage(chat_id, '', 0, '_set_ *Rank* _for_ *[ '..user_id..' ]* _To :_ *'..value..'*', 0, "md")
  end
end
local function info_by_reply(arg, data)
    if tonumber(data.sender_user_id_) then
local function info_cb(arg, data)
    if data.username_ then
  username = "@"..check_markdown(data.username_)
    else
  username = ""
  end
    if data.first_name_ then
  firstname = check_markdown(data.first_name_)
    else
  firstname = ""
  end
    if data.last_name_ then
  lastname = check_markdown(data.last_name_)
    else
  lastname = ""
  end
	local hash = 'rank:'..arg.chat_id..':variables'
   local text = "_First name :_ *"..firstname.."*\n_Last name :_ *"..lastname.."*\n_Username :_ "..username.."\n_ID :_ *"..data.id_.."*\n"
		    if data.id_ == tonumber(MRlucas) then
		       text = text..'_Rank :_ *Executive Admin*\n'
			   elseif is_sudo1(data.id_) then
	           text = text..'_Rank :_ *Full Access Admin*\n'
		     elseif is_admin1(data.id_) then
		       text = text..'_Rank :_ *Bot Admin*\n'
		     elseif is_owner1(arg.chat_id, data.id_) then
		       text = text..'_Rank :_ *Group Owner*\n'
		     elseif is_mod1(arg.chat_id, data.id_) then
		       text = text..'_Rank :_ *Group Moderator*\n'
		 else
		       text = text..'_Rank :_ *Group Member*\n'
			end
         local user_info = {} 
  local uhash = 'user:'..data.id_
  local user = redis:hgetall(uhash)
  local um_hash = 'msgs:'..data.id_..':'..arg.chat_id
  user_info_msgs = tonumber(redis:get(um_hash) or 0)
  text = text..'Total messages : '..user_info_msgs..'\n'
  text = text..BDRpm
  tdcli.sendMessage(arg.chat_id, arg.msgid, 0, text, 0, "md")
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, info_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_,msgid=data.id_})
    else
tdcli.sendMessage(data.chat_id_, "", 0, "*User not found*", 0, "md")
   end
end

local function info_by_username(arg, data)
    if tonumber(data.id_) then
    if data.type_.user_.username_ then
  username = "@"..check_markdown(data.type_.user_.username_)
    else
  username = ""
  end
    if data.type_.user_.first_name_ then
  firstname = check_markdown(data.type_.user_.first_name_)
    else
  firstname = ""
  end
    if data.type_.user_.last_name_ then
  lastname = check_markdown(data.type_.user_.last_name_)
    else
  lastname = ""
  end
	local hash = 'rank:'..arg.chat_id..':variables'
   local text = "_First name :_ *"..firstname.."*\n_Last name :_ *"..lastname.."*\n_Username :_ "..username.."\n_ID :_ *"..data.id_.."*\n"
		    if data.id_ == tonumber(MRlucas) then
		       text = text..'_Rank :_ *Executive Admin*\n'
			   elseif is_sudo1(data.id_) then
	           text = text..'_Rank :_ *Full Access Admin*\n'
		     elseif is_admin1(data.id_) then
		       text = text..'_Rank :_ *Bot Admin*\n'
		     elseif is_owner1(arg.chat_id, data.id_) then
		       text = text..'_Rank :_ *Group Owner*\n'
		     elseif is_mod1(arg.chat_id, data.id_) then
		       text = text..'_Rank :_ *Group Moderator*\n'
		 else
		       text = text..'_Rank :_ *Group Member*\n'
			end
         local user_info = {} 
  local uhash = 'user:'..data.id_
  local user = redis:hgetall(uhash)
  local um_hash = 'msgs:'..data.id_..':'..arg.chat_id
  user_info_msgs = tonumber(redis:get(um_hash) or 0)
  text = text..'Total messages : '..user_info_msgs..'\n'
  text = text..BDRpm
  tdcli.sendMessage(arg.chat_id, arg.msgid, 0, text, 0, "md")
   else
   tdcli.sendMessage(arg.chat_id, "", 0, "*User not found*", 0, "md")
  end
end

local function info_by_id(arg, data)
      if tonumber(data.id_) then
    if data.username_ then
  username = "@"..check_markdown(data.username_)
    else
  username = ""
  end
    if data.first_name_ then
  firstname = check_markdown(data.first_name_)
    else
  firstname = ""
  end
    if data.last_name_ then
  lastname = check_markdown(data.last_name_)
    else
  lastname = ""
  end
	local hash = 'rank:'..arg.chat_id..':variables'
   local text = "_First name :_ *"..firstname.."*\n_Last name :_ *"..lastname.."*\n_Username :_ "..username.."\n_ID :_ *"..data.id_.."*\n"
		    if data.id_ == tonumber(MRlucas) then
		       text = text..'_Rank :_ *Executive Admin*\n'
			   elseif is_sudo1(data.id_) then
	           text = text..'_Rank :_ *Full Access Admin*\n'
		     elseif is_admin1(data.id_) then
		       text = text..'_Rank :_ *Bot Admin*\n'
		     elseif is_owner1(arg.chat_id, data.id_) then
		       text = text..'_Rank :_ *Group Owner*\n'
		     elseif is_mod1(arg.chat_id, data.id_) then
		       text = text..'_Rank :_ *Group Moderator*\n'
		 else
		       text = text..'_Rank :_ *Group Member*\n'
			end
         local user_info = {} 
  local uhash = 'user:'..data.id_
  local user = redis:hgetall(uhash)
  local um_hash = 'msgs:'..data.id_..':'..arg.chat_id
  user_info_msgs = tonumber(redis:get(um_hash) or 0)
  text = text..'Total messages : '..user_info_msgs..'\n'
  text = text..BDRpm
  tdcli.sendMessage(arg.chat_id, arg.msgid, 0, text, 0, "md")
   else
   tdcli.sendMessage(arg.chat_id, "", 0, "*User not found*", 0, "md")
   end
end

local function setrank_by_reply(arg, data)

end

if matches[1]:lower() == "me" or matches[1] == "من" then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, info_by_reply, {chat_id=msg.chat_id_})
  end
  if matches[2] and string.match(matches[2], '^%d+$') and tonumber(msg.reply_to_message_id_) == 0 then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, info_by_id, {chat_id=msg.chat_id_,user_id=matches[2],msgid=msg.id_})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') and tonumber(msg.reply_to_message_id_) == 0 then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, info_by_username, {chat_id=msg.chat_id_,username=matches[2],msgid=msg.id_})
      end
  if not matches[2] and tonumber(msg.reply_to_message_id_) == 0 then
local function info2_cb(arg, data)
      if tonumber(data.id_) then
    if data.username_ then
  username = "@"..check_markdown(data.username_)
    else
  username = ""
  end
    if data.first_name_ then
  firstname = check_markdown(data.first_name_)
    else
  firstname = ""
  end
    if data.last_name_ then
  lastname = check_markdown(data.last_name_)
    else
  lastname = ""
  end
	local hash = 'rank:'..arg.chat_id..':variables'
   local text = "_First name :_ *"..firstname.."*\n_Last name :_ *"..lastname.."*\n_Username :_ "..username.."\n_ID :_ *"..data.id_.."*\n"
		    if data.id_ == tonumber(MRlucas) then
		       text = text..'_Rank :_ *Executive Admin*\n'
			   elseif is_sudo1(data.id_) then
	           text = text..'_Rank :_ *Full Access Admin*\n'
		     elseif is_admin1(data.id_) then
		       text = text..'_Rank :_ *Bot Admin*\n'
		     elseif is_owner1(arg.chat_id, data.id_) then
		       text = text..'_Rank :_ *Group Owner*\n'
		     elseif is_mod1(arg.chat_id, data.id_) then
		       text = text..'_Rank :_ *Group Moderator*\n'
		 else
		       text = text..'_Rank :_ *Group Member*\n'
		 end
         local user_info = {} 
  local uhash = 'user:'..data.id_
  local user = redis:hgetall(uhash)
  local um_hash = 'msgs:'..data.id_..':'..arg.chat_id
  user_info_msgs = tonumber(redis:get(um_hash) or 0)
  text = text..'Total messages : '..user_info_msgs..'\n'
  text = text..BDRpm
  tdcli.sendMessage(arg.chat_id, arg.msgid, 0, text, 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = msg.from.id,
  }, info_by_id, {chat_id=msg.chat_id_,user_id=msg.from.id,msgid=msg.id_})
      end
   end
-------------Echo--------------
if matches[1] == 'echo' or  matches[1] == 'اکو' then
local pext = matches[2]
tdcli.sendMessage(msg.to.id, 0,1, pext,1,'html')
end
  -----------cleanbot----------
   if matches[1] == 'cleanbot' or matches[1] == 'پاک کردن ربات' then
  function clbot(arg, data)
    for k, v in pairs(data.members_) do
      kick_user(v.user_id_, msg.to.id)
	end
    tdcli.sendMessage(msg.to.id, msg.id, 1, '_All Bots was cleared._', 1, 'md')
  end
  tdcli.getChannelMembers(msg.to.id, 0, 'Bots', 200, clbot, nil)
  end
--------------Delete Message----------------
local function delmsg (i,naji)
    msgs = i.msgs 
    for k,v in pairs(naji.messages_) do
        msgs = msgs - 1
        tdcli.deleteMessages(v.chat_id_,{[0] = v.id_}, dl_cb, cmd)
        if msgs == 1 then
            tdcli.deleteMessages(naji.messages_[0].chat_id_,{[0] = naji.messages_[0].id_}, dl_cb, cmd)
            return false
        end
    end
    tdcli.getChatHistory(naji.messages_[0].chat_id_, naji.messages_[0].id_,0 , 100, delmsg, {msgs=msgs})
end
    if matches[1] == 'del' or matches[1] == 'حذف' and is_owner(msg) then
        if tostring(msg.to.id):match("^-100") then
            if tonumber(matches[2]) > 1000 or tonumber(matches[2]) < 1 then
                return  '🚫 *1000*> _تعداد پیام های قابل پاک سازی در هر دفعه_ >*1* 🚫'
            else
        tdcli.getChatHistory(msg.to.id, msg.id,0 , 100, delmsg, {msgs=matches[2]})
        return ""..matches[2].." _پیام اخیر با موفقیت پاکسازی شدند_ 🚮"
            end
        else
            return '⚠️ _این قابلیت فقط در سوپرگروه ممکن است_ ⚠️'
        end
	end	
--------------------------------
if matches[1]:lower() == 'clean' or matches[1] == 'پاک کردن' and matches[2]:lower() == 'blacklist' or matches[2] == 'بلک لیست' then
    if not is_mod(msg) then
      return -- «Mods allowed»
    end
	
    local function cleanbl(ext, res)
      if tonumber(res.total_count_) == 0 then -- «Blocklist is empty or maybe Bot is not group's admin»
        return tdcli.sendMessage(ext.chat_id, ext.msg_id, 0, '⚠️ _لیست مسدودی های گروه خالی است_ !', 1, 'md')
      end
      local x = 0
      for x,y in pairs(res.members_) do
        x = x + 1
        tdcli.changeChatMemberStatus(ext.chat_id, y.user_id_, 'Left', dl_cb, nil) -- «Changing user status to left, removes user from blocklist»
      end
      return tdcli.sendMessage(ext.chat_id, ext.msg_id, 0, '✅ _ کاربر از لیست مسدودی های گروه آزاد شدند_ !', 1, 'md')
    end
	
    return tdcli.getChannelMembers(msg.to.id, 0, 'Kicked', 200, cleanbl, {chat_id = msg.to.id, msg_id = msg.id}) -- «Gets channel blocklist»
  end
--------------------------------
if matches[1] == 'addkick' or matches[1] == 'افزودن ریمو' and is_owner(msg) then
        if gp_type(msg.to.id) == "channel" then
            tdcli.getChannelMembers(msg.to.id, 0, "Kicked", 200, function (i, naji)
                for k,v in pairs(naji.members_) do
                    tdcli.addChatMember(i.chat_id, v.user_id_, 50, dl_cb, nil)
                end
            end, {chat_id=msg.to.id})
            return "*>Banned User has been added Again Sussecfully✅*"
        end
        return "*Just in the super group may be :(*"
    end
--------------------------------
if matches[1] == 'ping'or matches[1] == 'ربات' then
tdcli.sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, './data/ping.webp', '', dl_cb,msg.reply_id, nil)
end
--------------------------------
if matches [1] == 'setnerkh' or matches[1] == 'تنظیم نرخ' then 
if not is_admin(msg) then 
return '_You are Not_ *Moderator*' 
end 
local nerkh = matches[2] 
redis:set('bot:nerkh',nerkh) 
return 'نرخ باموفقیت ثبت گردید😐❤️' 
end 
if matches[1] == 'nerkh' or matches[1] == 'نرخ' then 
if not is_mod(msg) then 
return 
end 
    local hash = ('bot:nerkh') 
    local nerkh = redis:get(hash) 
    if not nerkh then 
    return 'نرخ ثبت نشده📛' 
    else 
     tdcli.sendMessage(msg.chat_id_, 0, 1, nerkh, 1, 'html') 
    end 
    end 
if matches[1]== "delnerkh" or matches[1] == 'پاک کردن نرخ' then 
if not is_admin(msg) then 
return '_You are Not_ *Moderator*' 
end 
    local hash = ('bot:nerkh') 
    redis:del(hash) 
return 'نرخ پاک شد🗑' 
end
------------------------------------
   if msg.to.type ~= 'pv' then
chat = msg.to.id
user = msg.from.id
	local function check_newmember(arg, data)
		test = load_data(_config.moderation.data)
		lock_bots = test[arg.chat_id]['settings']['lock_bots']
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    if data.type_.ID == "UserTypeBot" then
      if not is_owner(arg.msg) and lock_bots == 'yes' then
kick_user(data.id_, arg.chat_id)
end
end
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if is_banned(data.id_, arg.chat_id) then
   if not lang then
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, "_User_ "..user_name.." *[ "..data.id_.." ]* _is banned_", 0, "md")
   else
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, "_کاربر_ "..user_name.." *[ "..data.id.."]*_banned_", 0, "md")
end
kick_user(data.id_, arg.chat_id)
end
if is_gbanned(data.id_) then
     if not lang then
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, "_User_ "..user_name.." *[ "..data.id_.." ]* _is globally banned_", 0, "md")
    else
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, "_کاربر_ "..user_name.." *[ "..data.id_.." ]* _از تمام گروه های ربات محروم است_", 0, "md")
   end
kick_user(data.id_, arg.chat_id)
     end
	end
	if msg.adduser then
			tdcli_function ({
	      ID = "GetUser",
      	user_id_ = msg.adduser
    	}, check_newmember, {chat_id=chat,msg_id=msg.id,user_id=user,msg=msg})
	end
	if msg.joinuser then
			tdcli_function ({
	      ID = "GetUser",
      	user_id_ = msg.joinuser
    	}, check_newmember, {chat_id=chat,msg_id=msg.id,user_id=user,msg=msg})
	   end
 if is_silent_user(msg.from.id, msg.to.id) then
 del_msg(msg.to.id, msg.id)
    return false
 end
 if is_banned(msg.from.id, msg.to.id) then
 del_msg(msg.to.id, tonumber(msg.id))
     kick_user(msg.from.id, msg.to.id)
    return false
    end
 if is_gbanned(msg.from.id) then
 del_msg(msg.to.id, tonumber(msg.id))
     kick_user(msg.from.id, msg.to.id)
    return false
   end
 end
   return msg
end
local function action_by_reply(arg, data)
local hash = "gp_lang:"..data.chat_id_
local lang = redis:get(hash)
  local cmd = arg.cmd
if not tonumber(data.sender_user_id_) then return false end
if data.sender_user_id_ then
  if cmd == "ban" then
local function ban_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
   if is_mod1(arg.chat_id, data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_You can't ban_ *mods,owners and bot admins*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*شما نمیتوانید مدیران،صاحبان گروه، و ادمین های ربات رو از گروه محروم کنید*", 0, "md")
         end
     end
if administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already_ *banned*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* * از گروه محروم بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   kick_user(data.id_, arg.chat_id)
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *banned*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از گروه محروم شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, ban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
   if cmd == "unban" then
local function unban_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not_ *banned*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از گروه محروم نبود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *unbanned*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از محرومیت گروه خارج شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, unban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "silent" then
local function silent_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
   if is_mod1(arg.chat_id, data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_You can't silent_ *mods,owners and bot admins*", 0, "md")
    else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*شما نمیتوانید توانایی چت کردن رو از مدیران،صاحبان گروه، و ادمین های ربات بگیرید*", 0, "md")
       end
     end
if administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already_ *silent*", 0, "md")
  else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل توانایی چت کردن رو نداشت*", 0, "md")
     end
   end
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
  if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _added to_ *silent users list*", 0, "md")
  else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *توانایی چت کردن رو از دست داد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, silent_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "unsilent" then
local function unsilent_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not_ *silent*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل توانایی چت کردن را داشت*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _removed from_ *silent users list*", 0, "md")
  else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *توانایی چت کردن رو به دست آورد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, unsilent_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "banall" then
local function gban_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if not administration['gban_users'] then
    administration['gban_users'] = {}
    save_data(_config.moderation.data, administration)
    end
   if is_admin1(data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_You can't_ *globally ban* _other admins_", 0, "md")
  else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*شما نمیتوانید ادمین های ربات رو از تمامی گروه های ربات محروم کنید*", 0, "md")
        end
     end
if is_gbanned(data.id_) then
   if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already_ *globally banned*", 0, "md")
    else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از گروه های ربات محروم بود*", 0, "md")
      end
   end
  administration['gban_users'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   kick_user(data.id_, arg.chat_id)
     if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *globally banned*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از تمام گروه های ربات محروم شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, gban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "unbanall" then
local function ungban_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if not administration['gban_users'] then
    administration['gban_users'] = {}
    save_data(_config.moderation.data, administration)
    end
if not is_gbanned(data.id_) then
   if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not_ *globally banned*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از گروه های ربات محروم نبود*", 0, "md")
      end
   end
  administration['gban_users'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *globally unbanned*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از محرومیت گروه های ربات خارج شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, ungban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "kick" then
   if is_mod1(data.chat_id_, data.sender_user_id_) then
   if not lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "_You can't kick_ *mods,owners and bot admins*", 0, "md")
    elseif lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "*شما نمیتوانید مدیران،صاحبان گروه و ادمین های ربات رو اخراج کنید*", 0, "md")
   end
  else
     kick_user(data.sender_user_id_, data.chat_id_)
     end
  end
  if cmd == "delall" then
   if is_mod1(data.chat_id_, data.sender_user_id_) then
   if not lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "_You can't delete messages_ *mods,owners and bot admins*", 0, "md")
   elseif lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "*شما نمیتوانید پیام های مدیران،صاحبان گروه و ادمین های ربات رو پاک کنید*", 0, "md")
   end
  else
tdcli.deleteMessagesFromUser(data.chat_id_, data.sender_user_id_, dl_cb, nil)
   if not lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "_All_ *messages* _of_ *[ "..data.sender_user_id_.." ]* _has been_ *deleted*", 0, "md")
      elseif lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "*تمام پیام های* *[ "..data.sender_user_id_.." ]* *پاک شد*", 0, "md")
       end
    end
  end
else
    if lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "_کاربر یافت نشد_", 0, "md")
   else
  return tdcli.sendMessage(data.chat_id_, "", 0, "*User Not Found*", 0, "md")
      end
   end
end
local function action_by_username(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
  local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
if not arg.username then return false end
    if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end
  if cmd == "ban" then
   if is_mod1(arg.chat_id, data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_You can't ban_ *mods,owners and bot admins*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*شما نمیتوانید مدیران،صاحبان گروه، و ادمین های ربات رو از گروه محروم کنید*", 0, "md")
         end
     end
if administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already_ *banned*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* * از گروه محروم بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   kick_user(data.id_, arg.chat_id)
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *banned*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از گروه محروم شد*", 0, "md")
   end
end
   if cmd == "unban" then
if not administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not_ *banned*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از گروه محروم نبود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *unbanned*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از محرومیت گروه خارج شد*", 0, "md")
   end
end
  if cmd == "silent" then
   if is_mod1(arg.chat_id, data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_You can't silent_ *mods,owners and bot admins*", 0, "md")
    else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*شما نمیتوانید توانایی چت کردن رو از مدیران،صاحبان گروه، و ادمین های ربات بگیرید*", 0, "md")
       end
     end
if administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already_ *silent*", 0, "md")
  else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل توانایی چت کردن رو نداشت*", 0, "md")
     end
   end
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
  if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _added to_ *silent users list*", 0, "md")
  else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *توانایی چت کردن رو از دست داد*", 0, "md")
   end
end
  if cmd == "unsilent" then
if not administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not_ *silent*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل توانایی چت کردن را داشت*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _removed from_ *silent users list*", 0, "md")
  else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *توانایی چت کردن رو به دست آورد*", 0, "md")
   end
end
  if cmd == "banall" then
  if not administration['gban_users'] then
    administration['gban_users'] = {}
    save_data(_config.moderation.data, administration)
    end
   if is_admin1(data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_You can't_ *globally ban* _other admins_", 0, "md")
  else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*شما نمیتوانید ادمین های ربات رو از تمامی گروه های ربات محروم کنید*", 0, "md")
        end
     end
if is_gbanned(data.id_) then
   if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already_ *globally banned*", 0, "md")
    else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از گروه های ربات محروم بود*", 0, "md")
      end
   end
  administration['gban_users'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   kick_user(data.id_, arg.chat_id)
     if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *globally banned*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از تمام گروه های ربات محروم شد*", 0, "md")
   end
end
  if cmd == "unbanall" then
  if not administration['gban_users'] then
    administration['gban_users'] = {}
    save_data(_config.moderation.data, administration)
    end
if not is_gbanned(data.id_) then
     if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not_ *globally banned*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از گروه های ربات محروم نبود*", 0, "md")
      end
   end
  administration['gban_users'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *globally unbanned*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از محرومیت گروه های ربات خارج شد*", 0, "md")
   end
end
  if cmd == "kick" then
   if is_mod1(arg.chat_id, data.id_) then
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_You can't kick_ *mods,owners and bot admins*", 0, "md")
    elseif lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "*شما نمیتوانید مدیران،صاحبان گروه و ادمین های ربات رو اخراج کنید*", 0, "md")
   end
  else
     kick_user(data.id_, arg.chat_id)
     end
  end
  if cmd == "delall" then
   if is_mod1(arg.chat_id, data.id_) then
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_You can't delete messages_ *mods,owners and bot admins*", 0, "md")
   elseif lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "*شما نمیتوانید پیام های مدیران،صاحبان گروه و ادمین های ربات رو پاک کنید*", 0, "md")
   end
  else
tdcli.deleteMessagesFromUser(arg.chat_id, data.id_, dl_cb, nil)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_All_ *messages* _of_ "..user_name.." *[ "..data.id_.." ]* _has been_ *deleted*", 0, "md")
      elseif lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "*تمام پیام های* "..user_name.." *[ "..data.id_.." ]* *پاک شد*", 0, "md")
       end
    end
  end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر یافت نشد_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*User Not Found*", 0, "md")
      end
   end
end

if is_banned(msg.from.id, msg.to.id) or is_gbanned(msg.from.id, msg.to.id) or is_silent_user(msg.from.id, msg.to.id) then
return false
end
local userid = tonumber(matches[2])
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
chat = msg.to.id
user = msg.from.id
   if msg.to.type ~= 'pv' then
 if (matches[1]:lower() == "kick" or matches[1] == "اخراج") and is_mod(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="kick"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if is_mod1(msg.to.id, userid) then
   if not lang then
     tdcli.sendMessage(msg.to.id, "", 0, "_You can't kick mods,owners or bot admins_", 0, "md")
   elseif lang then
     tdcli.sendMessage(msg.to.id, "", 0, "*شما نمیتوانید مدیران،صاحبان گروه و ادمین های ربات رو اخراج کنید*", 0, "md")
         end
     else
kick_user(matches[2], msg.to.id)
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="kick"})
         end
      end
 if (matches[1]:lower() == "delall" or matches[1] == "حذف پیام") and is_mod(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="delall"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if is_mod1(msg.to.id, userid) then
   if not lang then
   return tdcli.sendMessage(msg.to.id, "", 0, "_You can't delete messages mods,owners or bot admins_", 0, "md")
     elseif lang then
   return tdcli.sendMessage(msg.to.id, "", 0, "*شما نمیتوانید پیام های مدیران،صاحبان گروه و ادمین های ربات رو پاک کنید*", 0, "md")
   end
     else
tdcli.deleteMessagesFromUser(msg.to.id, matches[2], dl_cb, nil)
    if not lang then
  return tdcli.sendMessage(msg.to.id, "", 0, "_All_ *messages* _of_ *[ "..matches[2].." ]* _has been_ *deleted*", 0, "md")
   elseif lang then
  return tdcli.sendMessage(msg.to.id, "", 0, "*تمامی پیام های* *[ "..matches[2].." ]* *پاک شد*", 0, "md")
         end
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="delall"})
         end
      end
   end
 if (matches[1]:lower() == "banall" or matches[1] == "سوپر بن") and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="banall"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if is_admin1(userid) then
   if not lang then
    return tdcli.sendMessage(msg.to.id, "", 0, "_You can't globally ban other admins_", 0, "md")
else
    return tdcli.sendMessage(msg.to.id, "", 0, "*شما نمیتوانید ادمین های ربات رو از گروه های ربات محروم کنید*", 0, "md")
        end
     end
   if is_gbanned(matches[2]) then
   if not lang then
  return tdcli.sendMessage(msg.to.id, "", 0, "*User "..matches[2].." is already globally banned*", 0, "md")
    else
  return tdcli.sendMessage(msg.to.id, "", 0, "*کاربر "..matches[2].." از گروه های ربات محروم بود*", 0, "md")
        end
     end
  data['gban_users'][tostring(matches[2])] = ""
    save_data(_config.moderation.data, data)
kick_user(matches[2], msg.to.id)
   if not lang then
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "*User "..matches[2].." has been globally banned*", 0, "md")
    else
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "*کاربر "..matches[2].." از تمام گروه هار ربات محروم شد*", 0, "md")
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="banall"})
      end
   end
 if (matches[1]:lower() == "unbanall" or matches[1] == "حذف سوپر بن") and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="unbanall"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if not is_gbanned(matches[2]) then
     if not lang then
   return tdcli.sendMessage(msg.to.id, "", 0, "*User "..matches[2].." is not globally banned*", 0, "md")
    else
   return tdcli.sendMessage(msg.to.id, "", 0, "*کاربر "..matches[2].." از گروه های ربات محروم نبود*", 0, "md")
        end
     end
  data['gban_users'][tostring(matches[2])] = nil
    save_data(_config.moderation.data, data)
   if not lang then
return tdcli.sendMessage(msg.to.id, msg.id, 0, "*User "..matches[2].." has been globally unbanned*", 0, "md")
   else
return tdcli.sendMessage(msg.to.id, msg.id, 0, "*کاربر "..matches[2].." از محرومیت گروه های ربات خارج شد*", 0, "md")
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="unbanall"})
      end
   end
   if msg.to.type ~= 'pv' then
 if matches[1]:lower() == "ban" or matches[1] == "بن" and is_mod(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="ban"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if is_mod1(msg.to.id, userid) then
     if not lang then
    return tdcli.sendMessage(msg.to.id, "", 0, "_You can't ban mods,owners or bot admins_", 0, "md")
    else
    return tdcli.sendMessage(msg.to.id, "", 0, "*شما نمیتوانید مدیران،صاحبان گروه و ادمین های ربات رو از گروه محروم کنید*", 0, "md")
        end
     end
   if is_banned(matches[2], msg.to.id) then
   if not lang then
  return tdcli.sendMessage(msg.to.id, "", 0, "_User "..matches[2].." is already banned_", 0, "md")
  else
  return tdcli.sendMessage(msg.to.id, "", 0, "*کاربر "..matches[2].." از گروه محروم بود*", 0, "md")
        end
     end
data[tostring(chat)]['banned'][tostring(matches[2])] = ""
    save_data(_config.moderation.data, data)
kick_user(matches[2], msg.to.id)
   if not lang then
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "_User "..matches[2].." has been banned_", 0, "md")
  else
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "*کاربر "..matches[2].." از گروه محروم شد*", 0, "md")
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
     tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="ban"})
      end
   end
 if (matches[1]:lower() == "unban" or matches[1] == "حذف بن") and is_mod(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="unban"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if not is_banned(matches[2], msg.to.id) then
   if not lang then
   return tdcli.sendMessage(msg.to.id, "", 0, "_User "..matches[2].." is not banned_", 0, "md")
  else
   return tdcli.sendMessage(msg.to.id, "", 0, "*کاربر "..matches[2].." از گروه محروم نبود*", 0, "md")
        end
     end
data[tostring(chat)]['banned'][tostring(matches[2])] = nil
    save_data(_config.moderation.data, data)
   if not lang then
return tdcli.sendMessage(msg.to.id, msg.id, 0, "_User "..matches[2].." has been unbanned_", 0, "md")
   else
return tdcli.sendMessage(msg.to.id, msg.id, 0, "*کاربر "..matches[2].." از محرومیت گروه خارج شد*", 0, "md")
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="unban"})
      end
   end
 if (matches[1]:lower() == "silent" or matches[1] == "سکوت") and is_mod(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="silent"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if is_mod1(msg.to.id, userid) then
   if not lang then
   return tdcli.sendMessage(msg.to.id, "", 0, "_You can't silent mods,leaders or bot admins_", 0, "md")
 else
   return tdcli.sendMessage(msg.to.id, "", 0, "*شما نمیتوانید توانایی چت کردن رو از مدیران،صاحبان گروه و ادمین های ربات بگیرید*", 0, "md")
        end
     end
   if is_silent_user(matches[2], chat) then
   if not lang then
   return tdcli.sendMessage(msg.to.id, "", 0, "_User "..matches[2].." is already silent_", 0, "md")
   else
   return tdcli.sendMessage(msg.to.id, "", 0, "*کاربر "..matches[2].." از قبل توانایی چت کردن رو نداشت*", 0, "md")
        end
     end
data[tostring(chat)]['is_silent_users'][tostring(matches[2])] = ""
    save_data(_config.moderation.data, data)
    if not lang then
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "_User "..matches[2].." added to silent users list_", 0, "md")
  else
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "*کاربر "..matches[2].." توانایی چت کردن رو از دست داد*", 0, "md")
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="silent"})
      end
   end
 if (matches[1]:lower() == "unsilent" or matches[1] == "حذف سکوت") and is_mod(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="unsilent"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if not is_silent_user(matches[2], chat) then
     if not lang then
     return tdcli.sendMessage(msg.to.id, "", 0, "_User "..matches[2].." is not silent_", 0, "md")
   else
     return tdcli.sendMessage(msg.to.id, "", 0, "*کاربر "..matches[2].." از قبل توانایی چت کردن رو داشت*", 0, "md")
        end
     end
data[tostring(chat)]['is_silent_users'][tostring(matches[2])] = nil
    save_data(_config.moderation.data, data)
   if not lang then
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "_User "..matches[2].." removed from silent users list_", 0, "md")
  else
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "*کاربر "..matches[2].." توانایی چت کردن رو به دست آورد*", 0, "md")
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="unsilent"})
      end
   end
		if (matches[1]:lower() == 'clean' or matches[1] == "پاک کردن") and is_owner(msg) then
		if not lang then
			if matches[2]:lower() == 'bans' then
				if next(data[tostring(chat)]['banned']) == nil then

					return "_No_ *banned* _users in this group_"
				end
				for k,v in pairs(data[tostring(chat)]['banned']) do
					data[tostring(chat)]['banned'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
				return "_All_ *banned* _users has been unbanned_"
			end
			if matches[2]:lower() == 'silentlist' then
				if next(data[tostring(chat)]['is_silent_users']) == nil then
					return "_No_ *silent* _users in this group_"
				end
				for k,v in pairs(data[tostring(chat)]['is_silent_users']) do
					data[tostring(chat)]['is_silent_users'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				    end
				return "*Silent list* _has been cleaned_"
			    end
				else
				
			if matches[2] == 'بن لیست' then
				if next(data[tostring(chat)]['banned']) == nil then
					return "*هیچ کاربری از این گروه محروم نشده*"
				end
				for k,v in pairs(data[tostring(chat)]['banned']) do
					data[tostring(chat)]['banned'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
				return "*تمام کاربران محروم شده از گروه از محرومیت خارج شدند*"
			end
			if matches[2] == 'لیست سکوت' then
				if next(data[tostring(chat)]['is_silent_users']) == nil then
					return "*لیست کاربران سایلنت شده خالی است*"
				end
				for k,v in pairs(data[tostring(chat)]['is_silent_users']) do
					data[tostring(chat)]['is_silent_users'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				    end
				return "*لیست کاربران سایلنت شده پاک شد*"
			    end
        end
		end
     end
		if (matches[1]:lower() == 'clean' or matches[1]:lower() == 'پاک کردن') and is_sudo(msg) then
		if not lang then
			if matches[2]:lower() == 'gbans' then
				if next(data['gban_users']) == nil then
					return "_No_ *globally banned* _users available_"
				end
				for k,v in pairs(data['gban_users']) do
					data['gban_users'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
				return "_All_ *globally banned* _users has been unbanned_"
			end
			else
		if matches[2] == 'لیست سوپر بن' then
				if next(data['gban_users']) == nil then
					return "*هیچ کاربری از گروه های ربات محروم نشده*"
				end
				for k,v in pairs(data['gban_users']) do
					data['gban_users'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
				return "*تمام کاربرانی که از گروه های ربات محروم بودند از محرومیت خارج شدند*"
			end
			end
     end
if matches[1]:lower() == "gbanlist" and is_admin(msg) or matches[1] == "لیست سوپر بن" and is_admin(msg) then
  return gbanned_list(msg)
 end
   if msg.to.type ~= 'pv' then
if matches[1]:lower() == "silentlist" and is_mod(msg) or matches[1] == "لیست سکوت" and is_mod(msg) then
  return silent_users_list(chat)
 end
if matches[1]:lower() == "banlist" and is_mod(msg) or matches[1] == "لیست بن" and is_mod(msg) then
  return banned_list(chat)
     end
------------------Invite---------------------
function getMessage(chat_id, message_id,cb)
  tdcli_function ({
    ID = "GetMessage",
    chat_id_ = chat_id,
    message_id_ = message_id
  }, cb, nil)
end
-------------------------------------------
function from_username(msg)
  function gfrom_user(extra,result,success)
    if result.username_ then
      F = result.username_
    else
      F = 'nil'
    end
    return F
  end
  local username = getUser(msg.sender_user_id_,gfrom_user)
  return username
end
 --Start Function
  if matches[1] == "invite" and matches[2] and is_owner(msg) then
if string.match(matches[2], '^%d+$') then
tdcli.addChatMember(msg.to.id, matches[2], 0)
end
------------------------Username------------------------------------------------------------------------------------
if matches[1] == "invite" and matches[2] and is_owner(msg) then
if string.match(matches[2], '^.*$') then
function invite_by_username(extra, result, success)
if result.id_ then
tdcli.addChatMember(msg.to.id, result.id_, 5)
end
end
resolve_username(matches[2],invite_by_username)
end
end
------------------------Reply---------------------------------------------------------------------------------------
if matches[1] == "invite" and msg.reply_to_message_id_ ~= 0 and is_owner(msg) then
function inv_reply(extra, result, success)
tdcli.addChatMember(msg.to.id, result.sender_user_id_, 5)
end
getMessage(msg.chat_id_, msg.reply_to_message_id_,inv_reply)
end
end
-----------------------------------------
if matches[1]:lower() == "help" or matches[1] == 'راهنما' and is_mod(msg) then
if not lang then
text = [[
*▪️PCT Bot Commands: *

*🔹!helplock*
🔻Show locks Help

*🔹!helpmute*
🔻Show mutes Help

*🔹!helptools*
🔻Show Tools Help

*🔹!helpfun*
🔻Show Fun Help

*🔹!helpmanag*
🔻Show manag Help

—---------------------------------------------------------------------

⚠️This Help List Only For *Moderators/Owners!*
🔺Its Means, Only Group  *Moderators/Owners* Can Use It!
 *Good luck ;)*

—---------------------------------------------------------------------—
®PCT BOT

]]



elseif lang then

text = [[
*▪️راهنمای عملکرد ربات: *

_🔹راهنما قفل_
🔻برای مشاهده دستورات قفل 

_🔹راهنما بیصدا_
🔻برای مشاهده دستورات بیصدا 

_🔹راهنما ابزار_
🔻برای مشاهده دستورات سودو ها 

_🔹!راهنمای سرگرمی_
🔻برای مشاهده دستورات سرگرمی 

_🔹راهنما مدیریتی_
🔻برای مشاهده دستورات مدیریتی گروه

—---------------------------------------------------------------------

⚠️_این راهنما فقط برای مدیران/مالکان گروه میباشد!
این به این معناست که فقط مدیران/مالکان گروه میتوانند از دستورات بالا استفاده کنند!_
*موفق باشید ;)*

—---------------------------------------------------------------------—
®PCT BOT

]]
end
return text
end
-----------------------------------------
if matches[1]:lower() == "helplock" or matches[1] == 'راهنما قفل' and is_mod(msg) then
if not lang then
lock = [[
*PCT Bot Commands:*
`!lock🔒`

*link ~ join ~ tag ~ edit ~ arabic ~ webpage ~ bots ~ spam ~ flood ~ markdown ~ mention ~ pin ~ cmds ~ badword ~ username ~ english*

_If This Actions Lock, Bot Check Actions And Delete Them_

`!unlock🔓`

*link ~ join ~ tag ~ edit ~ arabic ~ webpage ~ bots ~ spam ~ flood ~ markdown ~ mention ~ pin ~ cmds ~ badword ~ username ~ english*

_If This Actions Unlock, Bot Not Delete Them_

_You Can Use_ *[!/#]* _To Run The Commands_
_This Help List Only For_ *Moderators/Owners!*
_Its Means, Only Group_ *Moderators/Owners* _Can Use It!_
*Good luck ;)*]]

elseif lang then

lock = [[
*دستورات ربات پروتکشن:*					
*قفل🔒*

`لینک ~ ویرایش ~ تگ ~ یوزرنیم ~ انگلیسی ~ عربی ~ وب ~ ربات ~ هرزنامه ~ پیام مکرر ~ فراخوانی ~ سنجاق ~ دستورات ~ ورود ~ فونت ~ تبچی`

_در صورت قفل بودن فعالیت ها, ربات آنهارا حذف خواهد کرد_

*باز🔓*

`لینک ~ ویرایش ~ تگ ~ یوزرنیم ~ انگلیسی ~ عربی ~ وب ~ ربات ~ هرزنامه ~ پیام مکرر ~ فراخوانی ~ سنجاق ~ دستورات ~ ورود ~ فونت ~ تبچی`

_در صورت باز نبودن فعالیت ها, ربات آنهارا حذف نخواهد کرد_

_این راهنما فقط برای مدیران/مالکان گروه میباشد!
این به این معناست که فقط مدیران/مالکان گروه میتوانند از دستورات بالا استفاده کنند!_

]]
end
return lock
end
-----------------------------------------
if matches[1]:lower() == "helpmute" or matches[1] == 'راهنما بیصدا' and is_mod(msg) then
if not lang then
mute = [[
*PCT Bot Commands:*

`!mute🔇`

*gif ~ photo ~ document ~ sticker ~ keyboard ~ video ~ text ~ forward ~ location ~ audio ~ voice ~ contact ~ all*

_If This Actions Lock, Bot Check Actions And Delete Them_

*!unmute🔊* 
*gif ~ photo ~ document ~ sticker ~ keyboard ~ video ~ text ~ forward ~ location ~ audio ~ voice ~ contact ~ all*

_If This Actions Unlock, Bot Not Delete Them_

*!mutetime* 
`(hour) (minute) (seconds)`

_Mute group at this time_ 

*!mutehours* 
`(number)`

_Mute group at this time_
 
*!muteminutes* 
`(number)`

_Mute group at this time_ 

_You Can Use_ *[!/#]* _To Run The Commands_
_This Help List Only For_ *Moderators/Owners!*
_Its Means, Only Group_ *Moderators/Owners* _Can Use It!_
*Good luck ;)*]]

elseif lang then

mute = [[
*دستورات ربات پروتکشن:*

*بیصدا🔇*

`همه ~ تصاویر متحرک ~ عکس ~ اسناد ~ برچسب ~ صفحه کلید ~ فیلم ~ متن ~ نقل قول ~ موقعیت ~ اهنگ ~ صدا ~ مخاطب ~ کیبورد شیشه ای ~ بازی ~ خدمات تلگرام`

_در صورت بیصدا بودن فعالیت ها, ربات آنهارا حذف خواهد کرد_

*باصدا🔊*

`همه ~ تصاویر متحرک ~ عکس ~ اسناد ~ برچسب ~ صفحه کلید ~ فیلم ~ متن ~ نقل قول ~ موقعیت ~ اهنگ ~ صدا ~ مخاطب ~ کیبورد شیشه ای ~ بازی ~ خدمات تلگرام`

_در صورت بیصدا نبودن فعالیت ها, ربات آنهارا حذف نخواهد کرد_

*زمان بیصدا* `(ساعت) (دقیقه) (ثانیه)`
_بیصدا کردن گروه با ساعت و دقیقه و ثانیه_ 
*ساعت بیصدا* `(عدد)`
_بیصدا کردن گروه در ساعت_ 
*دقیقه بیصدا* `(عدد)`
_بیصدا کردن گروه در دقیقه_ 
*ثانیه بیصدا* `(عدد)`
_بیصدا کردن گروه در ثانیه_ 

_این راهنما فقط برای مدیران/مالکان گروه میباشد!
این به این معناست که فقط مدیران/مالکان گروه میتوانند از دستورات بالا استفاده کنند!_
*موفق باشید ;)*]]
end
return mute
end
-----------------------------------------
if matches[1]:lower() == "helpmanag" or matches[1] == 'راهنما مدیریتی' and is_mod(msg) then
if not lang then
Management = [[
*PCT Bot Management:*
*!setmanager* `[username|id|reply]` 
_Add User To Group Admins(CreatorBot)_

*!Remmanager* `[username|id|reply]` 
 _Remove User From Owner List(CreatorBot)_

*!setowner* `[username|id|reply]` 
_Set Group Owner(Multi Owner)_

*!remowner* `[username|id|reply]` 
 _Remove User From Owner List_

*!promote* `[username|id|reply]` 
_Promote User To Group Admin_

*!demote* `[username|id|reply]` 
_Demote User From Group Admins List_

*!setflood* `[2-50]`
_Set Flooding Number_

*!silent* `[username|id|reply]` 
_Silent User From Group_

*!unsilent* `[username|id|reply]` 
_Unsilent User From Group_

*!kick* `[username|id|reply]` 
_Kick User From Group_

*!ban* `[username|id|reply]` 
_Ban User From Group_

*!unban* `[username|id|reply]` 
_UnBan User From Group_

*!res* `[username]`
_Show User ID_

*!id* `[reply]`
_Show User ID_

*!whois* `[id]`
_Show User's Username And Name_

*!clean* `[bans | mods | bots | rules | about | silentlist | filtelist | welcome]`   
_Bot Clean Them_

*!filter* `[word]`
_Word filter_

*!unfilter* `[word]`
_Word unfilter_

*!pin* `[reply]`
_Pin Your Message_

*!unpin* 
_Unpin Pinned Message_

*!welcome enable/disable*
_Enable Or Disable Group Welcome_

*!settings*
_Show Group Settings_

*!cmds* `[member | moderator | owner]`
_set cmd_

*!whitelist* `[+ | -]`
_Add User To White List_

*!silentlist*
_Show Silented Users List_

*!filterlist*
_Show Filtered Words List_

*!banlist*
_Show Banned Users List_

*!ownerlist*
_Show Group Owners List_ 

*!whitelist*
_Show Group whitelist List_

*!modlist* 
_Show Group Moderators List_

*!rules*
_Show Group Rules_

*!about*
_Show Group Description_

*!id*
_Show Your And Chat ID_

*!gpinfo*
_Show Group Information_

*!newlink*
_Create A New Link_

*!newlink pv*
_Create A New Link The Pv_

*!link*
_Show Group Link_

*!link pv*
_Send Group Link In Your Private Message_

*!setlang fa*
_Set Persian Language_

*!setwelcome [text]*
_set Welcome Message_

_You Can Use_ *[!/#]* _To Run The Commands_
_This Help List Only For_ *Moderators/Owners!*
_Its Means, Only Group_ *Moderators/Owners* _Can Use It!_
*Good luck ;)*]]

elseif lang then

Management = [[
*دستورات ربات پروتکشن:*

*ادمین گروه* `[username|id|reply]` 
_افزودن ادمین گروه(درصورت اینکه ربات سازنده  گروه)_

*حذف ادمین گروه* `[username|id|reply]` 
_حذف ادمین گروه(درصورت اینکه ربات سازنده  گروه)_

*مالک* `[username|id|reply]` 
_انتخاب مالک گروه(قابل انتخاب چند مالک)_

*حذف مالک* `[username|id|reply]` 
 _حذف کردن فرد از فهرست مالکان گروه_

*مدیر* `[username|id|reply]` 
_ارتقا مقام کاربر به مدیر گروه_

*حذف مدیر* `[username|id|reply]` 
_تنزیل مقام مدیر به کاربر_

*تنظیم پیام مکرر* `[2-50]`
_تنظیم حداکثر تعداد پیام مکرر_

*سکوت* `[username|id|reply]` 
_بیصدا کردن کاربر در گروه_

*!حذف سکوت* `[username|id|reply]` 
_در آوردن کاربر از حالت بیصدا در گروه_

*!اخراج* `[username|id|reply]` 
_حذف کاربر از گروه_

*!بن* `[username|id|reply]` 
_مسدود کردن کاربر از گروه_

*!حذف بن* `[username|id|reply]` 
_در آوردن از حالت مسدودیت کاربر از گروه_

*کاربری* `[username]`
_نمایش شناسه کاربر_

*ایدی* `[reply]`
_نمایش شناسه کاربر_

*شناسه* `[id]`
_نمایش نام کاربر, نام کاربری و اطلاعات حساب_

*تنظیم*`[قوانین | نام | لینک | درباره | خوشآمد]`
_ربات آنهارا ثبت خواهد کرد_
*پاک کردن* `[بن | مدیران | ربات | قوانین | درباره | لیست سکوت | خوشآمد]`   
_ربات آنهارا پاک خواهد کرد_

*لیست سفید* `[+|-]`
_افزودن افراد به لیست سفید_

*فیلتر* `[کلمه]`
_فیلتر‌کلمه مورد نظر_

*حذف فیلتر* `[کلمه]`
_ازاد کردن کلمه مورد نظر_

*سنجاق* `[reply]`
_ربات پیام شمارا در گروه سنجاق خواهد کرد_

*حذف سنجاق* 
_ربات پیام سنجاق شده در گروه را حذف خواهد کرد_

*!خوشآمد فعال/غیرفعال*
_فعال یا غیرفعال کردن خوشآمد گویی_

*تنظیمات*
_نمایش تنظیمات گروه_

*دستورات* `[کاربر | مدیر | مالک]`	
_نتخاب کردن قفل cmd بر چه مدیریتی_

*لیست سکوت*
_نمایش فهرست افراد بیصدا_

*فیلتر لیست*
_نمایش لیست کلمات فیلتر شده_

*لیست سفید*
_نمایش افراد سفید شده از گروه_

*لیست بن*
_نمایش افراد مسدود شده از گروه_

*لیست مالکان*
_نمایش فهرست مالکان گروه_ 

*لیست مدیران* 
_نمایش فهرست مدیران گروه_

*قوانین*
_نمایش قوانین گروه_

*درباره*
_نمایش درباره گروه_

*ایدی*
_نمایش شناسه شما و گروه_

*اطلاعات گروه*
_نمایش اطلاعات گروه_

*لینک جدید*
_ساخت لینک جدید_

*لینک جدید خصوصی*
_ساخت لینک جدید در پیوی_

*لینک*
_نمایش لینک گروه_

*لینک خصوصی*
_ارسال لینک گروه به چت خصوصی شما_

*زبان انگلیسی*
_تنظیم زبان انگلیسی_

*!تنظیم خوشآمد [متن]*
_ثبت پیام خوش آمد گویی_

_این راهنما فقط برای مدیران/مالکان گروه میباشد!
این به این معناست که فقط مدیران/مالکان گروه میتوانند از دستورات بالا استفاده کنند!_
*موفق باشید ;)*]]
end
return Management
end
-----------------------------------------
if matches[1]:lower() == "helpfun" or matches[1] == "راهنما سرگرمی" and is_mod(msg) then
if not lang then
helpfun = [[
_PCT Reborn Fun Help Commands:_

*!time*
_Get time in a sticker_

*!short* `[link]`
_Make short url_

*!voice* `[text]`
_Convert text to voice_

*!tr* `[lang] [word]`
_Translates FA to EN and EN to FA_
_Example:_
*!tr fa hi*

*!sticker* `[word]`
_Convert text to sticker_

*!photo* `[word]`
_Convert text to photo_

*!azan* `[city]`
_Get Azan time for your city_

*!calc* `[number]`
Calculator

*!praytime* `[city]`
_Get Patent (Pray Time)_

*!tosticker* `[reply]`
_Convert photo to sticker_

*!tophoto* `[reply]`
_Convert text to photo_

*!weather* `[city]`
_Get weather_

_You can use_ *[!/#]* _at the beginning of commands._

*Good luck ;)*]]
tdcli.sendMessage(msg.chat_id_, 0, 1, helpfun, 1, 'md')
else

helpfun = [[
_راهنمای سرگرمی ربات پروتکشن:_
*ساعت*
_دریافت ساعت به صورت استیکر_

*لینک کوتاه* `[لینک]`
_کوتاه کننده لینک_

*تبدیل به صدا* `[متن]`
_تبدیل متن به صدا_

*ترجمه* `[زبان]` `[کلمه]`
_ترجمه متن فارسی به انگلیسی وبرعکس_
_مثال:_
_ترجمه زبان سلام_

*استیکر* `[کلمه]`
_تبدیل متن به استیکر_

*عکس* `[کلمه]`
_تبدیل متن به عکس_

*اذان* `[شهر]`
_دریافت اذان_

*حساب کن* `[عدد]`
_ماشین حساب_

*ساعات شرعی* `[شهر]`
_اعلام ساعات شرعی_

*تبدیل به استیکر* `[ریپلی]`
_تبدیل عکس به استیکر_

*تبدیل به عکس* `[ریپلی]`
_تبدیل استیکر‌به عکس_

*اب هوا* `[شهر]`
_دریافت اب وهوا_

*شما میتوانید از [!/#] در اول دستورات برای اجرای آنها بهره بگیرید*

موفق باشید ;)]]
tdcli.sendMessage(msg.chat_id_, 0, 1, helpfun, 1, 'md')
end
end
-----------------------------------------
if matches[1] == "helptools" or  matches[1] == "راهنما ابزار" and is_mod(msg) then
if not lang then
text = [[

_Sudoer And Admins PCT Bot Help :_

*!visudo* `[username|id|reply]`
_Add Sudo_

*!desudo* `[username|id|reply]`
_Demote Sudo_

*!sudolist *
_Sudo(s) list_

*!adminprom* `[username|id|reply]`
_Add admin for bot_

*!admindem* `[username|id|reply]`
_Demote bot admin_

*!adminlist *
_Admin(s) list_

*!leave *
_Leave current group_

*!autoleave* `[disable/enable]`
_Automatically leaves group_

*!creategroup* `[text]`
_Create normal group_

*!createsuper* `[text]`
_Create supergroup_

*!tosuper *
_Convert to supergroup_

*!chats*
_List of added groups_

*!join* `[id]`
_Adds you to the group_

*!rem* `[id]`
_Remove a group from Database_

*!import* `[link]`
_Bot joins via link_

*!setbotname* `[text]`
_Change bot's name_

*!setbotusername* `[text]`
_Change bot's username_

*!delbotusername *
_Delete bot's username_

*!markread* `[off/on]`
_Second mark_

*!broadcast* `[text]`
_Send message to all added groups_

*!bc* `[text] [gpid]`
_Send message to a specific group_

*!sendfile* `[folder] [file]`
_Send file from folder_

*!sendplug* `[plug]`
_Send plugin_

*!del* `[Reply]`
_Remove message Person you are_

*!save* `[plugin name] [reply]`
_Save plugin by reply_

*!savefile* `[address/filename] [reply]`
_Save File by reply to specific folder_

*!clear cache*
_Clear All Cache Of .telegram-cli/data_

*!check*
_Stated Expiration Date_

*!check* `[GroupID]`
_Stated Expiration Date Of Specific Group_

*!charge* `[GroupID]` `[Number Of Days]`
_Set Expire Time For Specific Group_

*!charge* `[Number Of Days]`
_Set Expire Time For Group_

*!jointo* `[GroupID]`
_Invite You To Specific Group_

*!leave* `[GroupID]`
_Leave Bot From Specific Group_

_You can use_ *[!/#]* _at the beginning of commands._

`This help is only for sudoers/bot admins.`
 
*This means only the sudoers and its bot admins can use mentioned commands.*

*Good luck ;)*]]
tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md')
else

text = [[
_راهنمای ادمین و سودو های ربات پروتکشن:_

*سودو* `[username|id|reply]`
_اضافه کردن سودو_

*حذف سودو* `[username|id|reply]`
_حذف کردن سودو_

*لیست سودو* 
_لیست سودو‌های ربات_

*ادمین* `[username|id|reply]`
_اضافه کردن ادمین به ربات_

*حذف ادمین* `[username|id|reply]`
_حذف فرد از ادمینی ربات_

*لیست ادمین* 
_لیست ادمین ها_

*خروج* 
_خارج شدن ربات از گروه_

*خروج خودکار* `[غیرفعال/فعال | موقعیت]`
_خروج خودکار_

*ساخت گروه* `[اسم انتخابی]`
_ساخت گروه ریلم_

*ساخت سوپر گروه* `[اسم انتخابی]`
_ساخت سوپر گروه_

*تبدیل به سوپر* 
_تبدیل به سوپر گروه_

*لیست گروه ها*
_لیست گروه های مدیریتی ربات_

*افزودن* `[ایدی گروه]`
_جوین شدن توسط ربات_

*حذف گروه* `[ایدی گروه]`
_حذف گروه ازطریق پنل مدیریتی_

*ورود لینک* `[لینک_]`
_جوین شدن ربات توسط لینک_

*تغییر نام ربات* `[text]`
_تغییر اسم ربات_

*تغییر یوزرنیم ربات* `[text]`
_تغییر یوزرنیم ربات_

*حذف یوزرنیم ربات* 
_پاک کردن یوزرنیم ربات_

*تیک دوم* `[فعال/غیرفعال]`
_تیک دوم_

*ارسال به همه* `[متن]`
_فرستادن پیام به تمام گروه های مدیریتی ربات_

*ارسال* `[متن]` `[ایدی گروه]`
_ارسال پیام مورد نظر به گروه خاص_

*ارسال فایل* `[cd]` `[file]`
_ارسال فایل موردنظر از پوشه خاص_

*ارسال پلاگین* `[اسم پلاگین]`
_ارسال پلاگ مورد نظر_

* ذخیره پلاگین* `[اسم پلاگین] [reply]`
_ذخیره کردن پلاگین_

*ذخیره فایل* `[address/filename] [reply]`
_ذخیره کردن فایل در پوشه مورد نظر_

*پاک کردن حافظه*
_پاک کردن کش مسیر .telegram-cli/data_

*اعتبار*
_اعلام تاریخ انقضای گروه_

*اعتبار* `[ایدی گروه]`
_اعلام تاریخ انقضای گروه مورد نظر_

*شارژ* `[ایدی گروه]` `[تعداد روز]`
_تنظیم تاریخ انقضای گروه مورد نظر_

*شارژ* `[تعداد روز]`
_تنظیم تاریخ انقضای گروه_

*ورود به* `[ایدی گروه]`
_دعوت شدن شما توسط ربات به گروه مورد نظر_

*خروج* `[ایدی گروه]`
_خارج شدن ربات از گروه مورد نظر_

*شما میتوانید از [!/#] در اول دستورات برای اجرای آنها بهره بگیرید*

_این راهنما فقط برای سودو ها/ادمین های ربات میباشد!_

`این به این معناست که فقط سودو ها/ادمین های ربات میتوانند از دستورات بالا استفاده کنند!`

*موفق باشید ;)*]]
tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md')
end
end
--------------------- Welcome -----------------------
	if (matches[1]:lower() == "welcome" or matches[1] == 'خوشآمد') and is_mod(msg) then
	if not lang then
		if matches[2] == "enable" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "yes" then
				return "_Group_ *welcome* *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
			else
		data[tostring(chat)]['settings']['welcome'] = "yes"
	    save_data(_config.moderation.data, data)
				return "_Group_ *welcome* *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
			end
		end
		
		if matches[2] == "disable" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "no" then
				return "_Group_ *Welcome* *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫"
			else
		data[tostring(chat)]['settings']['welcome'] = "no"
	    save_data(_config.moderation.data, data)
				return "_Group_ *welcome* *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
			end
		end
		else
				if matches[2] == "فعال" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "yes" then
				return "_خوشآمد گویی از قبل فعال بود_"
			else
		data[tostring(chat)]['settings']['welcome'] = "yes"
	    save_data(_config.moderation.data, data)
				return "_خوشآمد گویی فعال شد_"
			end
		end
		
		if matches[2] == "غیرفعال" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "no" then
				return "_خوشآمد گویی از قبل فعال نبود_"
			else
		data[tostring(chat)]['settings']['welcome'] = "no"
	    save_data(_config.moderation.data, data)
				return "_خوشآمد گویی غیرفعال شد_"
			end
		end
		end
	end
	if (matches[1]:lower() == "setwelcome" or matches[1] == 'تنظیم خوشآمد') and matches[2] and is_mod(msg) then
		data[tostring(chat)]['setwelcome'] = matches[2]
	    save_data(_config.moderation.data, data)
       if not lang then
		return "_Welcome Message Has Been Set To :_\n*"..matches[2].."*\n\n*You can use :*\n_{gpname} Group Name_\n_{rules} ➣ Show Group Rules_\n_{time} ➣ Show time english _\n_{date} ➣ Show date english _\n_{timefa} ➣ Show time persian _\n_{datefa} ➣ show date persian _\n_{name} ➣ New Member First Name_\n_{username} ➣ New Member Username_"
       else
		return "_پیام خوشآمد گویی تنظیم شد به :_\n*"..matches[2].."*\n\n*شما میتوانید از*\n_{gpname} نام گروه_\n_{rules} ➣ نمایش قوانین گروه_\n_{time} ➣ ساعت به زبان انگلیسی _\n_{date} ➣ تاریخ به زبان انگلیسی _\n_{timefa} ➣ ساعت به زبان فارسی _\n_{datefa} ➣ تاریخ به زبان فارسی _\n_{name} ➣ نام کاربر جدید_\n_{username} ➣ نام کاربری کاربر جدید_\n_استفاده کنید_"
        end
     end
	end
end
end
local checkmod = true
-----------------------------------------
local function pre_process(msg)
local chat = msg.to.id
local user = msg.from.id
local hash = "gp_lang:"..chat
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
 if checkmod and msg.text and msg.to.type == 'channel' then
	tdcli.getChannelMembers(msg.to.id, 0, 'Administrators', 200, function(a, b)
	local secchk = true
	checkmod = false
		for k,v in pairs(b.members_) do
			if v.user_id_ == tonumber(our_id) then
				secchk = false
			end
		end
		if secchk then
			checkmod = false
			if not lang then
				return tdcli.sendMessage(msg.to.id, 0, 1, '_Robot isn\'t Administrator, Please promote to Admin!_', 1, "md")
			else
				return tdcli.sendMessage(msg.to.id, 0, 1, '_لطفا برای کارکرد کامل دستورات، ربات را به مدیر گروه ارتقا دهید._', 1, "md")
			end
		end
	end, nil)
 end
	local function welcome_cb(arg, data)
	local url , res = http.request('http://irapi.ir/time/')
          if res ~= 200 then return "No connection" end
      local jdat = json:decode(url)
		administration = load_data(_config.moderation.data)
    if administration[arg.chat_id]['setwelcome'] then
     welcome = administration[arg.chat_id]['setwelcome']
      else
     if not lang then
     welcome = "*Welcome Dude*"
    elseif lang then
     welcome = "_خوش آمدید_"
        end
     end
 if administration[tostring(arg.chat_id)]['rules'] then
rules = administration[arg.chat_id]['rules']
else
   if not lang then
     rules = "ℹ️ The Default Rules :\n1⃣ No Flood.\n2⃣ No Spam.\n3⃣ No Advertising.\n4⃣ Try to stay on topic.\n5⃣ Forbidden any racist, sexual, homophobic or gore content.\n➡️ Repeated failure to comply with these rules will cause ban.\n@ProtectionTeam"
    elseif lang then
       rules = "ℹ️ قوانین پپیشفرض:\n1⃣ ارسال پیام مکرر ممنوع.\n2⃣ اسپم ممنوع.\n3⃣ تبلیغ ممنوع.\n4⃣ سعی کنید از موضوع خارج نشید.\n5⃣ هرنوع نژاد پرستی, شاخ بازی و پورنوگرافی ممنوع .\n➡️ از قوانین پیروی کنید, در صورت عدم رعایت قوانین اول اخطار و در صورت تکرار مسدود.\n@ProtectionTeam"
 end
end
if data.username_ then
user_name = "@"..check_markdown(data.username_)
else
user_name = ""
end
		local welcome = welcome:gsub("{rules}", rules)
		local welcome = welcome:gsub("{name}", check_markdown(data.first_name_..' '..(data.last_name_ or '')))
		local welcome = welcome:gsub("{username}", user_name)
		local welcome = welcome:gsub("{time}", jdat.ENtime)
		local welcome = welcome:gsub("{date}", jdat.ENdate)
		local welcome = welcome:gsub("{timefa}", jdat.FAtime)
		local welcome = welcome:gsub("{datefa}", jdat.FAdate)
		local welcome = welcome:gsub("{gpname}", arg.gp_name)
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, welcome, 0, "md")
	end
	if data[tostring(chat)] and data[tostring(chat)]['settings'] then
	if msg.adduser then
		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "yes" then
			tdcli.getUser(msg.adduser, welcome_cb, {chat_id=chat,msg_id=msg.id_,gp_name=msg.to.title})
		else
			return false
		end
	end
	if msg.joinuser then
		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "yes" then
			tdcli.getUser(msg.sender_user_id_, welcome_cb, {chat_id=chat,msg_id=msg.id_,gp_name=msg.to.title})
		else
			return false
        end
		end
	end
	return msg
 end
return {
  description = "Plugin to manage other plugins. Enable, disable or reload.", 
  usage = {
      moderator = {
          "!pl - [plugin] chat : disable plugin only this chat.",
          "!pl + [plugin] chat : enable plugin only this chat.",
          },
      sudo = {
          "!plist : list all plugins.",
          "!pl + [plugin] : enable plugin.",
          "!pl - [plugin] : disable plugin.",
          "!pl * : reloads all plugins." },
          },
patterns ={
command .. "([Ii]d)$",
command .. "([Aa]dd)$",
command .. "([Pp]lugin)$",
command .. "([Pp]l) (+) ([%w_%.%-]+)$",
command .. "([Pp]l) (-) ([%w_%.%-]+)$",
command .. "([Pp]l) (+) ([%w_%.%-]+) (chat)$",
command .. "([Pp]l) (-) ([%w_%.%-]+) (chat)$",
command .. "([Pp]l) (*)$",
command .. "([Rr]eload)$",
command .. "([Rr]em)$",
command .. "([Ii]d) (.*)$",
command .. "([Pp]in)$",
command .. "([Uu]npin)$",
command .. "([Gg]pinfo)$",
command .. "([Ss]etmanager)$",
command .. "([Ss]etmanager) (.*)$",
command .. "([Rr]emmanager)$",
command .. "([Rr]emmanager) (.*)$",
command .. "([Ww]hitelist) ([+-])$",
command .. "([Ww]hitelist) ([+-]) (.*)$",
command .. "([Ww]hitelist)$",
command .. "([Ss]etowner)$",
command .. "([Ss]etowner) (.*)$",
command .. "([Rr]emowner)$",
command .. "([Rr]emowner) (.*)$",
command .. "([Pp]romote)$",
command .. "([Pp]romote) (.*)$",
command .. "([Dd]emote)$",
command .. "([Dd]emote) (.*)$",
command .. "([Mm]odlist)$",
command .. "([Oo]wnerlist)$",
command .. "([Ll]ock) (.*)$",
command .. "([Uu]nlock) (.*)$",
command .. "([Mm]ute) (.*)$",
command .. "([Uu]nmute) (.*)$",
command .. "([Ll]ink)$",
command .. "([Ll]ink) (pv)$",
command .. "([Ss]etlink)$",
command .. "([Ss]etlink) ([https?://w]*.?telegram.me/joinchat/%S+)$",
command .. "([Ss]etlink) ([https?://w]*.?t.me/joinchat/%S+)$",
command .. "([Nn]ewlink)$",
command .. "([Nn]ewlink) (pv)$",  
command .. "([Rr]ules)$",
command .. "([Ss]ettings)$",
command .. "([Ss]etrules) (.*)$",
command .. "([Aa]bout)$",
command .. "([Ss]etabout) (.*)$",
command .. "([Ss]etname) (.*)$",
command .. "([Cc]lean) (.*)$",
command .. "([Ss]etflood) (%d+)$",
command .. "([Ss]etchar) (%d+)$",
command .. "([Ss]etfloodtime) (%d+)$",
command .. "([Rr]es) (.*)$",
command .. "([Cc]mds) (.*)$",
command .. "([Ww]hois) (%d+)$",
command .. "([Hh]elp)$",
command .. "([Ss]etlang) (fa)$",
command .. "([Ff]ilter) (.*)$",
command .. "([Uu]nfilter) (.*)$",
command .. "([Ff]ilterlist)$",
command .. "([Cc]onfig)$",
command .. "([Ss]etwelcome) (.*)",
command .. "([Ww]elcome) (.*)$",
command .. '([Mm]uteall) (status)$',
command .. '([Hh]elpmute)$',
command .. '([Mm]utetime) (%d+) (%d+) (%d+)$',
command .. '([Mm]utehours) (%d+)$',
command .. '([Mm]uteminutes) (%d+)$',
command .. '([Mm]uteseconds) (%d+)$',
command .. "([Hh]elplock)$",
command .. "([Hh]elpmanag)$",
command .. "([Hh]elpfun)$",
command .. "([Hh]elptools)$",
command .. "([Ii]nvite) @(.*)$",
command .. "([Ii]nvite) (.*)$",
command .. "([Ii]nvite)$",
command .. "([Ee]dit) (.*)$",
command .. "([Ee]dit) (.*)$",
command ..	"([Cc]lean) ([Bb]lacklist)$",
command ..	"([Aa]ddkick)$",
command ..	"([Cc]leanbot)$",
command ..  "([Pp]ing)$",
command ..  "([Ss]etnerkh) (.*)$",
command ..  "([Dd]elnerkh)$",
command ..  "([Nn]erkh)$",
command .. "([Ee]cho) (.*)$",
command .. "([Bb]anall)$",
command .. "([Bb]anall) (.*)$",
command .. "([Uu]nbanall)$",
command .. "([Uu]nbanall) (.*)$",
command .. "([Gg]banlist)$",
command .. "([Bb]an)$",
command .. "([Bb]an) (.*)$",
command .. "([Uu]nban)$",
command .. "([Uu]nban) (.*)$",
command .. "([Bb]anlist)$",
command .. "([Ss]ilent)$",
command .. "([Ss]ilent) (.*)$",
command .. "([Uu]nsilent)$",
command .. "([Uu]nsilent) (.*)$",
command .. "([Ss]ilentlist)$",
command .. "([Kk]ick)$",
command .. "([Kk]ick) (.*)$",
command .. "([Dd]elall)$",
command .. "([Dd]elall) (.*)$",
command .. "([Cc]lean) (.*)$",
command .. "([Dd][Ee][Ll]) (%d+)$",
"^([https?://w]*.?telegram.me/joinchat/%S+)$",
"^([https?://w]*.?t.me/joinchat/%S+)$",
"^([Ii][Dd])$",
"^([Aa][Dd][Dd])$",
"^([Rr][Ee][Mm])$",
"^([Ii][Dd]) (.*)$",
"^([Pp][Ii][Nn])$",
"^([Uu][Nn][Pp][Ii][Nn])$",
"^([Gg][Pp][Ii][Nn][Ff][Oo])$",
"^([Ss][Ee][Tt][Mm][Aa][Nn][Aa][Gg][Ee][Rr])$",
"^([Ss][Ee][Tt][Mm][Aa][Nn][Aa][Gg][Ee][Rr]) (.*)$",
"^([Rr][Ee][Mm][Mm][Aa][Nn][Aa][Gg][Ee][Rr])$",
"^([Rr][Ee][Mm][Mm][Aa][Nn][Aa][Gg][Ee][Rr]) (.*)$",
"^([Ww][Hh][Ii][Tt][Ee][Ll][Ii][Ss][Tt]) ([+-])$",
"^([Ww][Hh][Ii][Tt][Ee][Ll][Ii][Ss][Tt]) ([+-]) (.*)$",
"^([Ww][Hh][Ii][Tt][Ee][Ll][Ii][Ss][Tt])$",
"^([Ss][Ee][Tt][Oo][Ww][Nn][Ee][Rr])$",
"^([Ss][Ee][Tt][Oo][Ww][Nn][Ee][Rr]) (.*)$",
"^([Rr][Ee][Mm][Oo][Ww][Nn][Ee][Rr])$",
"^([Rr][Ee][Mm][Oo][Ww][Nn][Ee][Rr]) (.*)$",
"^([Pp][Rr][Oo][Mm][Oo][Tt][Ee])$",
"^([Pp][Rr][Oo][Mm][Oo][Tt][Ee]) (.*)$",
"^([Dd][Ee][Mm][Oo][Tt][Ee])$",
"^([Dd][Ee][Mm][Oo][Tt][Ee]) (.*)$",
"^([Mm][Oo][Dd][Ll][Ii][Ss][Tt])$",
"^([Oo][Ww][Nn][Ee][Rr][Ll][Ii][Ss][Tt])$",
"^([Ll][Oo][Cc][Kk]) (.*)$",
"^([Uu][Nn][Ll][Oo][Cc][Kk]) (.*)$",
"^([Mm][Uu][Tt][Ee]) (.*)$",
"^([Uu][Nn][Mm][Uu][Tt][Ee]) (.*)$",
"^([Ll][Ii][Nn][Kk])$",
"^([Ll][Ii][Nn][Kk]) (pv)$",
"^([Ss][Ee][Tt][Ll][Ii][Nn][Kk])$",
"^([Ss][Ee][Tt][Ll][Ii][Nn][Kk]) ([https?://w]*.?telegram.me/joinchat/%S+)$",
"^([Ss][Ee][Tt][Ll][Ii][Nn][Kk]) ([https?://w]*.?[Tt].me/joinchat/%S+)$",
"^([Nn][Ee][Ww][Ll][Ii][Nn][Kk])$",
"^([Nn][Ee][Ww][Ll][Ii][Nn][Kk]) (pv)$",  
"^([Rr][Uu][Ll][Ee][Ss])$",
"^([Ss][Ee][Tt][Tt][Ii][Nn][Gg][Ss])$",
"^([Mm][Uu][Tt][Ee][Ll][Ii][Ss][Tt])$",
"^([Ss][Ee][Tt][Rr][Uu][Ll][Ee][Ss]) (.*)$",
"^([Bb][Oo][Uu][Tt])$",
"^([Ss][Ee][Tt][Aa][Bb][Oo][Uu][Tt]) (.*)$",
"^([Ss][Ee][Tt][Nn][Aa][Mm][Ee]) (.*)$",
"^([Cc][Ll][Ee][Aa][Nn]) (.*)$",
"^([Ss][Ee][Tt][Ff][Ll][Oo][Oo][Dd]) (%d+)$",
"^([Ss][Ee][Tt][Cc][Hh][Aa][Rr]) (%d+)$",
"^([Ss][Ee][Tt][Ff][Ll][Oo][Oo][Dd][Tt][Ii][Mm][Ee]) (%d+)$",
"^([Rr][Ee][Ss]) (.*)$",
"^([Cc][Mm][Dd][Ss]) (.*)$",
"^([Ww][Hh][Oo][Ii][Ss]) (%d+)$",
"^([Hh][Ee][Ll][Pp])$",
"^([Ss][Ee][Tt][Ll][Aa][Nn][Gg]) (fa)$",
"^([Ff][Ii][Ll][Tt][Ee][Rr]) (.*)$",
"^([Uu][Nn][Ff][Ii][Ll][Tt][Ee][Rr]) (.*)$",
"^([Ff][Ii][Ll][Tt][Ee][Rr][Ll][Ii][Ss][Tt])$",
"^([Cc][Oo][Nn][Ff][Ii][Gg])$",
"^([Ss][Ee][Tt][Ww][Ee][Ll][Cc][Oo][Mm][Ee]) (.*)",
"^([Ww][Ee][Ll][Cc][Oo][Mm][Ee]) (.*)",
'^([Mm][Uu][Tt][Ee][Aa][Ll][Ll]) ([Ss][Tt][Aa][Tt][Uu][Ss])$',
'^([Hh][Ee][Ll][Pp][Mm][Uu][Tt][Ee])$',
'^([Mm][Uu][Tt][Ee][Tt][Ii][Mm][Ee]) (%d+) (%d+) (%d+)$',
'^([Mm][Uu][Tt][Ee][Hh][Oo][Uu][Rr][Ss]) (%d+)$',
'^([Mm][Uu][Tt][Ee][Mm][Ii][Nn][Uu][Tt][Ee][Ss]) (%d+)$',
'^([Mm][Uu][Tt][Ee][Ss][Ee][Cc][Oo][Nn][Dd][Ss]) (%d+)$',
"^([Hh][Ee][Ll][Pp][Ll][Oo][Cc][Kk])$",
"^([Hh][Ee][Ll][Pp][Mm][Aa][Nn][Aa][Gg])$",
"^([Hh][Ee][Ll][Pp][Ff][Uu][Nn])$",
"^([Hh][Ee][Ll][Pp][Tt][Oo][Oo][Ll][Ss])$",
"^([Pp]lugin)$",
"^([Pp]l) (+) ([%w_%.%-]+)$",
"^([Pp]l) (-) ([%w_%.%-]+)$",
"^([Pp]l) (+) ([%w_%.%-]+) (chat)$",
"^([Pp]l) (-) ([%w_%.%-]+) (chat)$",
"^([Pp]l) (*)$",
"^([Rr]eload)$",
"^([Cc]lean) ([Bb]lacklist)$",
"^([Aa]ddkick)$",
"^([Pp]ing)$",
"^([Dd]elnerkh)$",
"^([Ss]etnerkh) (.*)$",
"^([Ee]dit) (.*)$",
"^([Ee]dit) (.*)$",
"^([Ee]cho) (.*)$",
"^([Nn]erkh)$",
"^([Cc]leanbot)$",
"^([Ii]nvite)$", 
"^([Ii]nvite) @(.*)$",
"^([Ii]nvite) (.*)$",
"^([Bb]anall)$",
"^([Bb]anall) (.*)$",
"^([Uu]nbanall)$",
"^([Uu]nbanall) (.*)$",
"^([Gg]banlist)$",
"^([Bb]an)$",
"^([Bb]an) (.*)$",
"^([Uu]nban)$",
"^([Uu]nban) (.*)$",
"^([Bb]anlist)$",
"^([Ss]ilent)$",
"^([Ss]ilent) (.*)$",
"^([Uu]nsilent)$",
"^([Uu]nsilent) (.*)$",
"^([Ss]ilentlist)$",
"^([Kk]ick)$",
"^([Kk]ick) (.*)$",
"^([Dd]elall)$",
"^([Dd]elall) (.*)$",
"^([Cc]lean) (.*)$",
"^([Mm][Ee])$"
},
patterns_fa = {
'^(ایدی)$',
'^(ایدی) (.*)$',
'^(تنظیمات)$',
'^(سنجاق)$',
'^(حذف سنجاق)$',
'^(افزودن)$',
'^(حذف گروه)$',
'^(ادمین گروه)$',
'^(ادمین گروه) (.*)$',
'^(حذف ادمین گروه) (.*)$',
'^(حذف ادمین گروه)$',
'^(لیست سفید) ([+-]) (.*)$',
'^(لیست سفید) ([+-])$',
'^(لیست سفید)$',
'^(مالک)$',
'^(مالک) (.*)$',
'^(حذف مالک) (.*)$',
'^(حذف مالک)$',
'^(مدیر)$',
'^(مدیر) (.*)$',
'^(حذف مدیر)$',
'^(حذف مدیر) (.*)$',
'^(قفل) (.*)$',
'^(باز) (.*)$',
'^(بیصدا) (.*)$',
'^(باصدا) (.*)$',
'^(لینک جدید)$',
'^(لینک جدید) (خصوصی)$',
'^(اطلاعات گروه)$',
'^(دستورات) (.*)$',
'^(قوانین)$',
'^(لینک)$',
'^(تنظیم لینک)$',
'^(تنظیم لینک) ([https?://w]*.?telegram.me/joinchat/%S+)$',
'^(تنظیم لینک) ([https?://w]*.?t.me/joinchat/%S+)$',
'^(تنظیم قوانین) (.*)$',
'^(لینک) (خصوصی)$',
'^(کاربری) (.*)$',
'^(شناسه) (%d+)$',
'^(تنظیم پیام مکرر) (%d+)$',
'^(تنظیم زمان بررسی) (%d+)$',
'^(حداکثر حروف مجاز) (%d+)$',
'^(پاک کردن) (.*)$',
'^(درباره)$',
'^(تنظیم نام) (.*)$',
'^(تنظیم درباره) (.*)$',
'^(لیست فیلتر)$',
'^(لیست مالکان)$',
'^(لیست مدیران)$',
'^(راهنما)$',
'^(پیکربندی)$',
'^(فیلتر) (.*)$',
'^(حذف فیلتر) (.*)$',
'^(خوشآمد) (.*)$',
'^(تنظیم خوشآمد) (.*)$',
'^(ساعت بیصدا) (%d+)$',
'^(دقیقه بیصدا) (%d+)$',
'^(ثانیه بیصدا) (%d+)$',
'^(موقعیت) (بیصدا)$',
'^(زمان بیصدا) (%d+) (%d+) (%d+)$',
'^(زبان انگلیسی)$',
'^([https?://w]*.?telegram.me/joinchat/%S+)$',
'^([https?://w]*.?t.me/joinchat/%S+)$',
"^(راهنما قفل)$",
"^(راهنما مدیریتی)$",
"^(راهنما سرگرمی)$",
"^(راهنما ابزار)$",
"^(راهنما بیصدا)$",
"^(بارگذاری)$",
"^(لیست پلاگین)$",
"^(پلاگین) (+) ([%w_%.%-]+)$",
"^(پلاگین) (-) ([%w_%.%-]+)$",
"^(پلاگین) (+) ([%w_%.%-]+) (گروه)$",
"^(پلاگین) (-) ([%w_%.%-]+) (گروه)$", 
"^(پاک کردن) (بلک لیست)$",
"^(ربات)$",
"^(افزودن ریمو)$",
"^(نرخ)$",
 "^(تنظیم نرخ) (.*)$",
 "^(پاک کردن نرخ)$",
"^(من)$",
"^(پاک کردن ربات) (.*)$",
"^(اکو) (.*)$",
"^( ادیت) (.*)$",
"^(سوپر بن)$",
"^(سوپر بن) (.*)$",
"^(حذف سوپر بن)$",
"^(حذف سوپر بن) (.*)$",
"^(لیست سوپر بن)$",
"^(بن)$",
"^(بن) (.*)$",
"^(حذف بن)$",
"^(حذف بن) (.*)$",
"^(لیست بن)$",
"^(سکوت)$",
"^(سکوت) (.*)$",
"^(حذف سکوت)$",
"^(حذف سکوت) (.*)$",
"^(لیست سکوت)$",
"^(اخراج)$",
"^(اخراج) (.*)$",
"^(حذف پیام)$",
"^(حذف پیام) (.*)$",
 "^(پاک کردن) (.*)$",
"^(ادیت) (.*)$"
},
run=run,
pre_process = pre_process
}

-- ## @BeyondTeam
