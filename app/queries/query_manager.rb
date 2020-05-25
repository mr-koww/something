class QueryManager
  PER_PAGE_DEFAULT = 10

  attr_reader :cursor, :params, :per_page, :resources

  def initialize(params, scope)
    @scope = scope
    @params = params
    search
    filter
    pagination
  end

  private

  def search
    return if @params[:q].blank?
    @scope = @scope.merge(@scope.klass.search(@params[:q])) if @scope.klass.respond_to?(:search)
  end

  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  def filter
    return @scope if params[:filters].blank?

    arel_table = @scope.klass.arel_table

    nodes = nil
    params[:filters].each do |filter|
      query = JSON.parse(filter, symbolize_names: true)
      operator = query[:operator].to_sym
      field = query[:field].to_sym

      next unless arel_table[field].respond_to?(operator)

      node = arel_table[field].send(operator, query[:value])
      nodes ||= (nodes = node) && next
      nodes = params[:union] == 'true' ? nodes.and(node) : nodes.or(node)
    end
    @scope = @scope.where(nodes)
  end
  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

  def pagination
    @per_page = @params[:per_page] || PER_PAGE_DEFAULT
    @cursor = @params[:cursor]
    if @cursor.present?
      @resources = @scope.next(@cursor).limit(@per_page)
    else
      @resources = @scope.limit(@per_page)
    end
  end
end
