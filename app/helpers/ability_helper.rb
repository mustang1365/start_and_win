module AbilityHelper
  def can?(p_name, m_name = nil, extra = nil)
    @ability ||= current_user.current_ability
    has_permission?(p_name) && has_access_to_model?(p_name,m_name,extra)
  end

  def has_permission?(p_name)
    @ability[:permissions][p_name].present?
  end

  def has_access_to_model?(p_name,m_name,extra)
    if m_name.nil?
      true
    else
      m_class = m_name.class.name == 'Class' ? m_name.underscore : m_name.class.underscore
      @ability[:permissions][p_name].keys.include?(m_class) && (@ability[:permissions][p_name][m_class].nil? ||
          Ability.send(@ability[:permissions][p_name][m_class], current_user, m_name,extra))
    end
  end
end
