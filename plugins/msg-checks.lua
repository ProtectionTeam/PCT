local TIME_CHECK = 2

local function pre_process(msg)
local data = load_data(_config.moderation.data)
local chat = msg.to.id
local user = msg.from.id
local is_channel = msg.to.type == "channel"
local is_chat = msg.to.type == "chat"
local auto_leave = 'auto_leave_bot'
local hash = "gp_lang:"..chat
local lang = redis:get(hash)
local muteallchk = 'muteall:'..msg.to.id
if is_channel or is_chat then
        local TIME_CHECK = 2
        if data[tostring(chat)] then
          if data[tostring(chat)]['settings']['time_check'] then
            TIME_CHECK = tonumber(data[tostring(chat)]['settings']['time_check'])
          end
        end
    if msg.text then
  if msg.text:match("(.*)") then
    if not data[tostring(msg.to.id)] and not redis:get(auto_leave) and not is_admin(msg) then
  tdcli.sendMessage(msg.to.id, "", 0, "_This Is Not One Of My_ *Groups*", 0, "md")
  tdcli.changeChatMemberStatus(chat, our_id, 'Left', dl_cb, nil)
      end
   end
end
  if redis:get(muteallchk) and not is_mod(msg) and not is_whitelist(msg.from.id, msg.to.id) then
  if is_channel then
    del_msg(chat, tonumber(msg.id))
	elseif is_chat then
	kick_user(user, chat)
  end
  end
if not redis:get('autodeltime') then
redis:setex('autodeltime', 14400, true)
     run_bash("rm -rf ~/.telegram-cli/data/sticker/*")
     run_bash("rm -rf ~/.telegram-cli/data/photo/*")
     run_bash("rm -rf ~/.telegram-cli/data/animation/*")
     run_bash("rm -rf ~/.telegram-cli/data/video/*")
     run_bash("rm -rf ~/.telegram-cli/data/audio/*")
     run_bash("rm -rf ~/.telegram-cli/data/voice/*")
     run_bash("rm -rf ~/.telegram-cli/data/temp/*")
     run_bash("rm -rf ~/.telegram-cli/data/thumb/*")
     run_bash("rm -rf ~/.telegram-cli/data/document/*")
     run_bash("rm -rf ~/.telegram-cli/data/profile_photo/*")
     run_bash("rm -rf ~/.telegram-cli/data/encrypted/*")
	 run_bash("rm -rf ./data/photos/*")
end
    if data[tostring(chat)] and data[tostring(chat)]['settings'] then
		settings = data[tostring(chat)]['settings']
	else
		return
	end
	if settings.mute_gif then
		mute_gif = settings.mute_gif
	else
		mute_gif = 'no'
	end
   if settings.mute_photo then
		mute_photo = settings.mute_photo
	else
		mute_photo = 'no'
	end
	if settings.mute_sticker then
		mute_sticker = settings.mute_sticker
	else
		mute_sticker = 'no'
	end
	if settings.mute_contact then
		mute_contact = settings.mute_contact
	else
		mute_contact = 'no'
	end
	if settings.mute_inline then
		mute_inline = settings.mute_inline
	else
		mute_inline = 'no'
	end
	if settings.mute_game then
		mute_game = settings.mute_game
	else
		mute_game = 'no'
	end
	if settings.mute_text then
		mute_text = settings.mute_text
	else
		mute_text = 'no'
	end
	if settings.mute_keyboard then
		mute_keyboard = settings.mute_keyboard
	else
		mute_keyboard = 'no'
	end
	if settings.mute_forward then
		mute_forward = settings.mute_forward
	else
		mute_forward = 'no'
	end
	if settings.mute_location then
		mute_location = settings.mute_location
	else
		mute_location = 'no'
	end
   if settings.mute_document then
		mute_document = settings.mute_document
	else
		mute_document = 'no'
	end
	if settings.mute_voice then
		mute_voice = settings.mute_voice
	else
		mute_voice = 'no'
	end
	if settings.mute_audio then
		mute_audio = settings.mute_audio
	else
		mute_audio = 'no'
	end
	if settings.mute_video then
		mute_video = settings.mute_video
	else
		mute_video = 'no'
	end
	if settings.mute_tgservice then
		mute_tgservice = settings.mute_tgservice
	else
		mute_tgservice = 'no'
	end
	if settings.lock_link then
		lock_link = settings.lock_link
	else
		lock_link = 'no'
	end
	if settings.lock_join then
		lock_join = settings.lock_join
	else
		lock_join = 'no'
	end
	if settings.lock_tag then
		lock_tag = settings.lock_tag
	else
		lock_tag = 'no'
	end
	if settings.lock_username then
		lock_username = settings.lock_username
	else
		lock_username = 'no'
	end		
	if settings.lock_pin then
		lock_pin = settings.lock_pin
	else
		lock_pin = 'no'
	end
	if settings.lock_english then
		lock_english = settings.lock_english
	else
		lock_english = 'no'
	end		
	if settings.lock_arabic then
		lock_arabic = settings.lock_arabic
	else
		lock_arabic = 'no'
	end
	if settings.lock_mention then
		lock_mention = settings.lock_mention
	else
		lock_mention = 'no'
	end
		if settings.lock_edit then
		lock_edit = settings.lock_edit
	else
		lock_edit = 'no'
	end
		if settings.lock_spam then
		lock_spam = settings.lock_spam
	else
		lock_spam = 'no'
	end
	if settings.lock_flood then
		lock_flood = settings.lock_flood
	else
		lock_flood = 'no'
	end
	if settings.lock_markdown then
		lock_markdown = settings.lock_markdown
	else
		lock_markdown = 'no'
	end
	if settings.lock_webpage then
		lock_webpage = settings.lock_webpage
	else
		lock_webpage = 'no'
	end
	if settings.lock_tabchi then
		lock_tabchi = settings.lock_tabchi
	else
		lock_tabchi = 'no'
	end		
  if msg.adduser or msg.joinuser or msg.deluser then
  if mute_tgservice == "yes" then
del_msg(chat, tonumber(msg.id))
  end
end
if not is_mod(msg) and not is_whitelist(msg.from.id, msg.to.id) then
	if msg.adduser or msg.joinuser then
		if lock_join == "yes" then
			function join_kick(arg, data)
				kick_user(data.id_, msg.to.id)
			end
			if msg.adduser then
				tdcli.getUser(msg.adduser, join_kick, nil)
			elseif msg.joinuser then
				tdcli.getUser(msg.joinuser, join_kick, nil)
			end
		end
	end
end
   if msg.pinned and is_channel then
  if lock_pin == "yes" then
     if is_owner(msg) then
      return
     end
     if tonumber(msg.from.id) == our_id then
      return
     end
    local pin_msg = data[tostring(chat)]['pin']
      if pin_msg then
  tdcli.pinChannelMessage(msg.to.id, pin_msg, 1)
       elseif not pin_msg then
   tdcli.unpinChannelMessage(msg.to.id)
          end
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '<b>User ID :</b> <code>'..msg.from.id..'</code>\n<b>Username :</b> '..('@'..msg.from.username or '<i>No Username</i>')..'\n<i>شما اجازه دسترسی به سنجاق پیام را ندارید، به همین دلیل پیام قبلی مجدد سنجاق میگردد</i>', 0, "html")
     elseif not lang then
    tdcli.sendMessage(msg.to.id, msg.id, 0, '<b>User ID :</b> <code>'..msg.from.id..'</code>\n<b>Username :</b> '..('@'..msg.from.username or '<i>No Username</i>')..'\n<i>You Have Not Permission To Pin Message, Last Message Has Been Pinned Again</i>', 0, "html")
          end
      end
  end
      if not is_mod(msg) and not is_whitelist(msg.from.id, msg.to.id) then
if msg.edited and lock_edit == "yes" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
    end
  end
if msg.forward_info_ and mute_forward == "yes" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
    end
  end
if msg.photo_ and mute_photo == "yes" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
    if msg.video_ and mute_video == "yes" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
    if msg.document_ and mute_document == "yes" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
    if msg.sticker_ and mute_sticker == "yes" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
    if msg.animation_ and mute_gif == "yes" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
    if msg.contact_ and mute_contact == "yes" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
    if msg.location_ and mute_location == "yes" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
    if msg.voice_ and mute_voice == "yes" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
   if msg.content_ and mute_keyboard == "yes" then
  if msg.reply_markup_ and  msg.reply_markup_.ID == "ReplyMarkupInlineKeyboard" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
      end
   end
end
    if tonumber(msg.via_bot_user_id_) ~= 0 and mute_inline == "yes" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
    if msg.game_ and mute_game == "yes" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
    if msg.audio_ and mute_audio == "yes" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
if msg.media.caption then
local link_caption = msg.media.caption:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.media.caption:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.media.caption:match("[Tt].[Mm][Ee]/") or msg.media.caption:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/")
if link_caption
and lock_link == "yes" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
local tag_caption = msg.media.caption:match("#") 
if tag_caption and lock_tag == "yes" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
local username_caption = msg.media.caption:match("@") 
if username_caption and lock_username == "yes" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
if is_filter(msg, msg.media.caption) then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
      end
    end
local badword_caption = msg.media.caption:match("کس")or msg.media.caption:match("کص")or msg.media.caption:match("کون")or msg.media.caption:match("کیر")or msg.media.caption:match("ممه")or msg.media.caption:match("کیری")or msg.media.caption:match("حرومی")or msg.media.caption:match("ننه")or msg.media.caption:match("کصده")or msg.media.caption:match("کث")or msg.media.caption:match("کسکش")or msg.media.caption:match("کصکش")or msg.media.caption:match("لاشی")or msg.media.caption:match("ناموس")or msg.media.caption:match("جنده")or msg.media.caption:match("یتیم")or msg.media.caption:match("خارکسده")or msg.media.caption:match("مادرجنده")or msg.media.caption:match("حرومزاده")or msg.media.caption:match("خواهرجنده")or msg.media.caption:match("خواهرتو")or msg.media.caption:match("مادرتو")or msg.media.caption:match("کونی")or msg.media.caption:match("اوبی")or msg.media.caption:match("لاشی")or msg.media.caption:match("kir")or msg.media.caption:match("mame")or msg.media.caption:match("kos")or msg.media.caption:match("lashi")
if badword_caption and lock_badword == "yes" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end	
local tabchi_caption = msg.media.caption:match("ady")or msg.media.caption:match("Add")or msg.media.caption:match("add")or msg.media.caption:match("ادی عشقم")or msg.media.caption:match("ادشدی")or msg.media.caption:match("ادی بپر پیوی")or msg.media.caption:match("ادشد")or msg.media.caption:match("شرکن پیوی")or msg.media.caption:match("شرکن")or msg.media.caption:match("ادی پیوی شرکن")or msg.media.caption:match("پیوی شرکن")or msg.media.caption:match("ادد")or msg.media.caption:match("اد")
if tabchi_caption and lock_tabchi == "yes" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end	
local english_caption = msg.media.caption:match("[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz]")
if english_caption and lock_english == "yes" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
local arabic_caption = msg.media.caption:match("[\216-\219][\128-\191]")
if arabic_caption and lock_arabic == "yes" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
      end
   end
end
if msg.text then
			local _nl, ctrl_chars = string.gsub(msg.text, '%c', '')
        local max_chars = 40
        if data[tostring(msg.to.id)] then
          if data[tostring(msg.to.id)]['settings']['set_char'] then
            max_chars = tonumber(data[tostring(msg.to.id)]['settings']['set_char'])
          end
        end
			 local _nl, real_digits = string.gsub(msg.text, '%d', '')
			local max_real_digits = tonumber(max_chars) * 50
			local max_len = tonumber(max_chars) * 51
			if lock_spam == "yes" then
			if string.len(msg.text) > max_len or ctrl_chars > max_chars or real_digits > max_real_digits then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
      end
   end
end
local link_msg = msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.text:match("[Tt].[Mm][Ee]/") or msg.text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/")
if link_msg
and lock_link == "yes" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
local tag_msg = msg.text:match("#")
if tag_msg and lock_tag == "yes" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
local username_msg = msg.text:match("@")
if username_msg and lock_username == "yes" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
if is_filter(msg, msg.text) then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
      end
    end
local badword_msg = msg.text:match("کیر")or msg.text:match("کون")or msg.text:match("کص")or msg.text:match("کس")or msg.text:match("ممه")or msg.text:match("کیری")or msg.text:match("حرومی")or msg.text:match("ننه")or msg.text:match("کصده")or msg.text:match("کث")or msg.text:match("کسکش")or msg.text:match("کصکش")or msg.text:match("لاشی")or msg.text:match("ناموس")or msg.text:match("جنده")or msg.text:match("یتیم")or msg.text:match("خارکسده")or msg.text:match("مادرجنده")or msg.text:match("حرومزاده")or msg.text:match("خواهرجنده")or msg.text:match("خواهرتو")or msg.text:match("مادرتو")or msg.text:match("کونی")or msg.text:match("اوبی")or msg.text:match("لاشی")or msg.text:match("kir")or msg.text:match("kos")or msg.text:match("mame")or msg.text:match("lashi")
if badword_msg and lock_badword == "yes" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end	
local tabchi_msg = msg.text:match("add")or msg.text:match("Add")or msg.text:match("ady")or msg.text:match("add")or msg.text:match("ادی عشقم")or msg.text:match("ادشدی")or msg.text:match("ادی بپر پیوی")or msg.text:match("ادشد")or msg.text:match("شرکن پیوی")or msg.text:match("شرکن")or msg.text:match("ادی پیوی شرکن")or msg.text:match("پیوی شرکن")or msg.text:match("ادد")or msg.text:match("اد")
if tabchi_msg and lock_tabchi == "yes" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end	
local english_msg = msg.text:match("[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz]") 
if english_msg and lock_english == "yes" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
if is_filter(msg, msg.text) then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
      end
    end
local arabic_msg = msg.text:match("[\216-\219][\128-\191]")
if arabic_msg and lock_arabic == "yes" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
   end
end
if msg.text:match("(.*)")
and mute_text == "yes" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
     end
   end
end
if msg.content_.entities_ and msg.content_.entities_[0] then
    if msg.content_.entities_[0].ID == "MessageEntityMentionName" then
      if lock_mention == "yes" then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
             end
          end
      end
  if msg.content_.entities_[0].ID == "MessageEntityUrl" or msg.content_.entities_[0].ID == "MessageEntityTextUrl" then
      if lock_webpage == "yes" then
if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
             end
          end
      end
  if msg.content_.entities_[0].ID == "MessageEntityBold" or msg.content_.entities_[0].ID == "MessageEntityCode" or msg.content_.entities_[0].ID == "MessageEntityPre" or msg.content_.entities_[0].ID == "MessageEntityItalic" then
      if lock_markdown == "yes" then
if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
             end
          end
      end
 end
if msg.to.type ~= 'pv' then
  if lock_flood == "yes" then
    if is_mod(msg) and is_whitelist(msg.from.id, msg.to.id) then
    return
  end
  if msg.adduser or msg.joinuser then
    return
  end
    local hash = 'user:'..user..':msgs'
    local msgs = tonumber(redis:get(hash) or 0)
        local NUM_MSG_MAX = 5
        if data[tostring(chat)] then
          if data[tostring(chat)]['settings']['num_msg_max'] then
            NUM_MSG_MAX = tonumber(data[tostring(chat)]['settings']['num_msg_max'])
          end
        end
    if msgs > NUM_MSG_MAX then
   if msg.from.username then
      user_name = "@"..msg.from.username
         else
      user_name = msg.from.first_name
     end
if redis:get('sender:'..user..':flood') then
return
else
   del_msg(chat, msg.id)
    kick_user(user, chat)
	redis:del(hash)
   if not lang then
  tdcli.sendMessage(chat, msg.id, 0, "_User_ "..user_name.." `[ "..user.." ]` _has been_ *kicked* _because of_ *flooding*", 0, "md")
   elseif lang then
  tdcli.sendMessage(chat, msg.id, 0, "_کاربر_ "..user_name.." `[ "..user.." ]` _به دلیل ارسال پیام های مکرر اخراج شد_", 0, "md")
    end
redis:setex('sender:'..user..':flood', 30, true)
      end
    end
    redis:setex(hash, TIME_CHECK, msgs+1)
               end
           end
      end
   end
   return msg
end
return {
	patterns = {},
	patterns_fa = {},
	pre_process = pre_process
}
--End msg_checks.lua--
