require('toggleterm').setup{
  direction = 'horizontal',
  size = function(term)
    if term.direction == 'vertical' then
      return 80
    elseif term.direction == 'horizontal' then
		return 15
    end
  end,
}

