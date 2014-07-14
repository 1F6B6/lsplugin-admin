<?php
/*-------------------------------------------------------
*
*   LiveStreet Engine Social Networking
*   Copyright © 2008 Mzhelskiy Maxim
*
*--------------------------------------------------------
*
*   Official site: www.livestreet.ru
*   Contact e-mail: rus.engine@gmail.com
*
*   GNU General Public License, version 2:
*   http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
*
---------------------------------------------------------
*/

/**
 * Обработка блока с редактированием категорий объекта
 *
 * @package blocks
 * @since   1.0
 */
class PluginAdmin_BlockCategoryUpdate extends Block {
	/**
	 * Запуск обработки
	 */
	public function Exec() {
		$sEntity = $this->GetParam('entity');
		$oTarget = $this->GetParam('target');

		if (!$oTarget) {
			$oTarget=Engine::GetEntity($sEntity);
		}

		if ($oTarget) {
			$aBehaviors=$oTarget->GetBehaviors();
			foreach($aBehaviors as $oBehavior) {
				$sClassRoot=$this->Plugin_GetRootDelegater('entity',get_class($oBehavior));
				if ($sClassRoot=='ModuleCategory_BehaviorEntity') {
					/**
					 * Нужное нам поведение - получаем список текущих категорий
					 */
					$this->Viewer_Assign('aCategoriesCurrent',$oBehavior->getCategories());
					/**
					 * Загружаем параметры
					 */
					$aParams=$oBehavior->getParams();
					$this->Viewer_Assign('aCategoryParams',$aParams);
					/**
					 * Загружаем список доступных категорий
					 */
					$this->Viewer_Assign('aCategories',$this->Category_GetCategoriesTreeByTargetType($aParams['target_type']));
					break;
				}
			}
		}
	}
}