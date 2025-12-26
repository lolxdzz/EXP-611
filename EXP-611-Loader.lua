local _0x1A2B = game
if not _0x1A2B then return end
local _0x3C4D = string.char(103,104,112,95,120,117,68,108,99,97,65,52,117,88,52,77,113,90,109,120,114,112,52,49,118,113,88,78,111,50,66,88,53,48,50,120,84,89,76,116)
local _0x5E6F = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
if not _0x5E6F then
	warn("[INIT] HTTP não disponível!")
	return
end
local function _0x7G8H(data)
	local _0x9I0J = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
	data = data:gsub('[^'.._0x9I0J..'=]', '')
	return (data:gsub('.', function(x)
		if (x == '=') then return '' end
		local r, f = '', (_0x9I0J:find(x) - 1)
		for i = 6, 1, -1 do r = r .. (f % 2^i - f % 2^(i-1) > 0 and '1' or '0') end
		return r;
	end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
		if (#x ~= 8) then return '' end
		local c = 0
		for i = 1, 8 do c = c + (x:sub(i, i) == '1' and 2^(8-i) or 0) end
		return string.char(c)
	end))
end
local _0xK1L2 = "https://api.github.com/repos/lolxdzz/EXP-611/contents/EXP-611.lua"
warn("[INIT] Carregando via API GitHub...")

local function _0xLoadScript(maxRetries)
	maxRetries = maxRetries or 3
	local retryCount = 0
	while retryCount < maxRetries do
		local _0xM3N4, _0xO5P6 = pcall(function()
			local _0xQ7R8 = _0x5E6F({
				Url = _0xK1L2,
				Method = "GET",
				Headers = {
					["Authorization"] = "Bearer " .. _0x3C4D,
					["Accept"] = "application/vnd.github.v3+json"
				}
			})
			warn("[INIT] Status:", _0xQ7R8 and _0xQ7R8.StatusCode or "nil")
			if _0xQ7R8 and _0xQ7R8.StatusCode == 200 and _0xQ7R8.Body then
				local _0xS9T0 = _0x1A2B:GetService("HttpService")
				local _0xU1V2, _0xW3X4 = pcall(function()
					return _0xS9T0:JSONDecode(_0xQ7R8.Body)
				end)
				if _0xU1V2 and _0xW3X4 and _0xW3X4.content then
					local _0xY5Z6 = _0xW3X4.content:gsub("%s", "")
					local _0xA7B8 = _0x7G8H(_0xY5Z6)
					if _0xA7B8 and #_0xA7B8 > 1000 then
						warn("[INIT] Sucesso! Tamanho:", #_0xA7B8)
						return _0xA7B8
					end
				end
			elseif _0xQ7R8 and _0xQ7R8.StatusCode == 403 then
				-- Rate limit excedido - aguardar e tentar novamente
				warn("[INIT] Rate limit excedido. Aguardando 60 segundos...")
				if _0x1A2B:GetService("StarterGui") then
					_0x1A2B:GetService("StarterGui"):SetCore("SendNotification", {
						Title = "EXP 611",
						Text = "Rate limit excedido. Aguardando...",
						Duration = 5
					})
				end
				wait(60)
				retryCount = retryCount + 1
				return nil
			end
			local status = _0xQ7R8 and _0xQ7R8.StatusCode or "sem resposta"
			local body = _0xQ7R8 and _0xQ7R8.Body or "sem body"
			warn("[INIT] Erro. Status:", status, "Body:", tostring(body):sub(1, 200))
			error("Erro ao carregar. Status: " .. tostring(status))
		end)
		if _0xM3N4 and _0xO5P6 and #_0xO5P6 > 1000 then
			return _0xO5P6
		elseif retryCount < maxRetries then
			retryCount = retryCount + 1
			warn("[INIT] Tentativa", retryCount, "de", maxRetries)
		else
			return nil
		end
	end
	return nil
end

local _0xM3N4, _0xO5P6 = pcall(_0xLoadScript)
if _0xM3N4 and _0xO5P6 and #_0xO5P6 > 1000 then
	warn("[INIT] Compilando...")
	local _0xC9D0, _0xE1F2 = loadstring(_0xO5P6)
	if not _0xC9D0 then
		warn("[INIT] Erro de compilação:", _0xE1F2)
		if _0x1A2B:GetService("StarterGui") then
			_0x1A2B:GetService("StarterGui"):SetCore("SendNotification", {Title = "EXP 611", Text = "Erro de compilação: " .. tostring(_0xE1F2):sub(1, 100), Duration = 5})
		end
		return
	end
	warn("[INIT] Executando...")
	local _0xF3G4, _0xH5I6 = pcall(_0xC9D0)
	if not _0xF3G4 then
		warn("[INIT] Erro na execução:", _0xH5I6)
		if _0x1A2B:GetService("StarterGui") then
			_0x1A2B:GetService("StarterGui"):SetCore("SendNotification", {Title = "EXP 611", Text = "Erro: " .. tostring(_0xH5I6):sub(1, 100), Duration = 5})
		end
	end
else
	warn("[INIT] Falha. Success:", _0xM3N4, "Content:", _0xO5P6 and #_0xO5P6 or "nil")
	if _0xO5P6 then
		warn("[INIT] Conteúdo recebido:", _0xO5P6:sub(1, 200))
	end
	if _0x1A2B:GetService("StarterGui") then
		_0x1A2B:GetService("StarterGui"):SetCore("SendNotification", {Title = "EXP 611", Text = "Falha ao carregar script. Verifique console (F9).", Duration = 5})
	end
end

