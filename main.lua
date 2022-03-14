-- Author STR_Warrior --
-- Improved by mestow --

--SETTINGS--
CutFullTree = true
--SETTINGS

pw = {}
function Initialize(Plugin)
	PLUGIN = Plugin;
	
	Plugin:SetName("TreeTimber");
	Plugin:SetVersion(1);
	
	PluginManager = cRoot:Get():GetPluginManager();
	PluginManager:AddHook(cPluginManager.HOOK_PLAYER_BROKEN_BLOCK, MyOnPlayerBrokenBlock)

	LOG("Initialized " .. PLUGIN:GetName() .. " v" .. PLUGIN:GetVersion())
	return true;
end

function MyOnPlayerBrokenBlock(Player, BlockX, BlockY, BlockZ, BlockFace, BlockType, BlockMeta)
	if CutFullTree == true then
		if (Player:HasPermission("TreeAssist.CutFullTree") == false) then
			do return end;
		end;
		World = Player:GetWorld()
		blcky = BlockY + 1
			if BlockType == 17 then
				if (Player:GetEquippedItem().m_ItemType == E_ITEM_STONE_AXE) or (Player:GetEquippedItem().m_ItemType == E_ITEM_WOODEN_AXE) or (Player:GetEquippedItem().m_ItemType == E_ITEM_IRON_AXE) or (Player:GetEquippedItem().m_ItemType == E_ITEM_GOLD_AXE) or (Player:GetEquippedItem().m_ItemType == E_ITEM_DIAMOND_AXE) then
					if World:GetBlock(Vector3i(BlockX, BlockY - 1, BlockZ)) == 2 or World:GetBlock(Vector3i(BlockX, BlockY - 1, BlockZ)) == 3 and World:GetBlock(Vector3i(BlockX, BlockY + 1, BlockZ)) == 17 then
						while World:GetBlock(Vector3i(BlockX, blcky, BlockZ)) == BlockType do
							World:DigBlock(Vector3i(BlockX, blcky, BlockZ))
							blcky = blcky + 1
						end
						if tostring(BlockMeta) == "0" then
							World:SetBlock(Vector3i(BlockX, BlockY, BlockZ), E_BLOCK_SAPLING, E_META_SAPLING_APPLE)
							local Item = cItem(E_BLOCK_LOG, blcky - BlockY - 1, E_META_LOG_APPLE)
							Player:GetInventory():AddItem( Item )
						elseif tostring(BlockMeta) == "1" then
							World:SetBlock(Vector3i(BlockX, BlockY, BlockZ), E_BLOCK_SAPLING, E_META_SAPLING_CONIFER)
							local Item = cItem(E_BLOCK_LOG, blcky - BlockY - 1, E_META_LOG_CONIFER)
							Player:GetInventory():AddItem( Item )
						elseif tostring(BlockMeta) == "2" then
							World:SetBlock(Vector3i(BlockX, BlockY), BlockZ, E_BLOCK_SAPLING, E_META_SAPLING_BIRCH)
							local Item = cItem(E_BLOCK_LOG, blcky - BlockY - 1, E_META_LOG_BIRCH)
							Player:GetInventory():AddItem( Item )
						elseif tostring(BlockMeta) == "3" then
							World:SetBlock(Vector3i(BlockX, BlockY), BlockZ, E_BLOCK_SAPLING, E_META_SAPLING_JUNGLE)
							local Item = cItem(E_BLOCK_LOG, blcky - BlockY - 1, E_META_LOG_JUNGLE)
							Player:GetInventory():AddItem( Item )
						elseif tostring(BlockMeta) == "4" then
							World:SetBlock(Vector3i(BlockX, BlockY), BlockZ, E_BLOCK_SAPLING, E_META_SAPLING_DARK_OAK)
							local Item = cItem(E_BLOCK_LOG, blcky - BlockY - 1, E_META_NEW_LOG_DARK_OAK_WOOD)
							Player:GetInventory():AddItem( Item )
						end
					end
				end
			end
		else
		if (Player:HasPermission("TreeAssist.CutTree") == false) then
			do return end
		end
		World = Player:GetWorld()
		blcky = BlockY + 1
		if BlockType == 17 then
			if (Player:GetEquippedItem().m_ItemType == E_ITEM_STONE_AXE) or (Player:GetEquippedItem().m_ItemType == E_ITEM_WOODEN_AXE) or (Player:GetEquippedItem().m_ItemType == E_ITEM_IRON_AXE) or (Player:GetEquippedItem().m_ItemType == E_ITEM_GOLD_AXE) or (Player:GetEquippedItem().m_ItemType == E_ITEM_DIAMOND_AXE) then
				if World:GetBlock(Vector3i(BlockX, BlockY - 1, BlockZ)) == 2 or World:GetBlock(BlockX, BlockY - 1, BlockZ) == 3 and World:GetBlock(BlockX, BlockY + 1, BlockZ) == 17 then
					while World:GetBlock(Vector3i(BlockX, blcky, BlockZ)) == 17 do
						blcky = blcky + 1
					end
					World:DigBlock(BlockX, blcky - 1, BlockZ)
					if World:GetBlock(Vector3i(BlockX, BlockY + 1, BlockZ)) == 17 then
						World:SetBlock(Vector3i(BlockX, BlockY, BlockZ), BlockType, BlockMeta)
					else
						pw[Player:GetName()] = true
					end
				end
			end
		end
	end
	if pw[Player:GetName()] == true then
		World:SetBlock(Vector3i(BlockX, BlockY, BlockZ), BlockType, BlockMeta)
		pw[Player:GetName()] = false
	end
end

