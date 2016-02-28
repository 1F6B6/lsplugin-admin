{**
 * Блок статистики отображающий кол-во юзеров, блогов и т.д.
 *}

{$component = 'p-dashboard-actionbar-stats'}
{component_define_params params=[ 'mods', 'classes', 'attributes' ]}

{$data = [
    [
        text => {lang 'plugin.admin.actionbar.users' count=$aStats.count_all plural=true},
        count => $aStats.count_all
    ],
    [
        text => {lang 'plugin.admin.actionbar.registrations' count=$aUserGrowth.now_items plural=true},
        count => $aUserGrowth.now_items,
        growth => $aUserGrowth.growth
    ],
    [
        text => {lang 'plugin.admin.actionbar.topics' count=$iTotalTopicsCount plural=true},
        count => $iTotalTopicsCount
    ],
    [
        text => {lang 'plugin.admin.actionbar.blogs' count=$iTotalBlogsCount plural=true},
        count => $iTotalBlogsCount
    ],
    [
        text => {lang 'plugin.admin.actionbar.comments' count=$iTotalCommentsCount plural=true},
        count => $iTotalBlogsCount
    ]
]}

<ul class="{$component} {cmods name=$component mods=$mods} {$classes}" {cattr list=$attributes}>
	{foreach $data as $item}
		{if isset($item.count)}
			<li class="{$component}-item">
				<h3 class="{$component}-item-title">
					{abs(number_format($item.count, 0, '.', ' '))}

					{* Прирост/спад *}
					{if isset($item.growth) && $item.growth !== 0}
						{$change = ($item.growth > 0) ? 'up' : 'down'}

						<i class="{$component}-item-change" title="{lang 'plugin.admin.actionbar.$change'}: {abs($item.growth)}"></i>
					{/if}
				</h3>
				<p class="{$component}-item-text">{$item.text}</p>
			</li>
		{/if}
	{/foreach}
</ul>