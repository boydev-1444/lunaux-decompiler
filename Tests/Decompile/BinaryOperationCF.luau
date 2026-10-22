-- [[ lunaux-decompiler.dev | v1.4.7 | discord.gg/2mJUD4XDDT ]]
-- [[ Luau version 11 | Types version 3 | took 0.5ms ]]

print(if IsAdmin then if HasKeycard then "ACCESS_GRANTED" elseif IsGuest then "LIMITED_ACCESS" else "NO_KEYCARD" elseif IsBanned then "BANNED" elseif Coins >= 1000 then if OwnsVIP then "VIP_PLAYER" else "RICH_PLAYER" elseif Level >= 50 then if HasBadge then "PRO_PLAYER" else "EXPERIENCED_PLAYER" else "NEW_PLAYER")