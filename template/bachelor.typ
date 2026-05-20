#import "/template.typ": (
  Assign, IfElseChain, Return, While, algorithm, capfig, capsubfig, captab, multicite, nwpu-thesis, zh
)

#let three-line-table(..args) = {
  let named = args.named()
  let pos = args.pos()
  table(
    stroke: none,
    ..named,
    table.hline(y: 0, stroke: 1.5pt),
    table.hline(y: 1, stroke: 0.5pt),
    ..pos,
    table.hline(stroke: 1.5pt),
  )
}

#show: nwpu-thesis.with(
  anonymous: false, // 是否开启盲审模式
  info: (
    title: ("异构无人机集群通信网络", "路由规划方法研究"),
    author: "秦紫玄",
    major: "计算机科学与技术",
    supervisor: ("陈进朝", "教授"),
    submit-date: (year: 2026, month: 6),
  ),
  abstract: (
    content: [
      异构无人机集群通信网络由能力不同的 UAV 共同完成覆盖、转发和汇聚任务。与同构系统相比，各 UAV 的最大速度、覆盖半径、通信带宽、发射功率、缓存容量和能量容量并不相同，在同一任务中承担的角色也会有所区别。集群工作时，UAV–地面节点链路负责覆盖任务区域，UAV–UAV 链路承担空中转发，UAV–Sink 链路完成数据汇聚。这类网络常见于临时通信、区域监测和灾后应急通信等基础设施受限的场景。

      异构 UAV 集群的动态路由规划不是单纯的路径选择。UAV 飞行轨迹会改变地面覆盖范围和链路传输质量，链路速率又会影响缓存队列的泄放；高速飞行和高功率发射还会加快能量消耗。这些因素沿时间序列不断传递，问题因此具有高维、非线性、非光滑和强时序耦合特征。对这类连续优化问题，通用元启发式算法如果不利用任务结构，往往难以稳定形成覆盖与回传能力。本文据此研究异构无人机集群通信网络的动态路由规划方法。

      本文关注灾后应急通信中较常见的一类情形：地面通信基础设施受损，任务节点持续产生数据，网络需要快速重组。在该场景下，路由规划不能等同于传统网络中的固定路径选择或单一下一跳决策，而要和 UAV 运动控制、覆盖关系、链路速率、队列状态一起建模。本文将 UAV 的速度、航向角和发射功率作为联合优化对象，使无人机集群在移动过程中维持地面覆盖和数据回传。换言之，本文所说的路由规划，本质上是面向异构 UAV 控制序列的动态优化问题，优化时优先考虑覆盖与回传，再兼顾系统吞吐量、队列负载和能量消耗。

      模型部分从固定高度二维应急通信场景写起。系统包含多架异构 UAV、若干地面任务节点和一个固定 Sink 节点；UAV 覆盖任务节点后产生数据到达量，再经 UAV-UAV 链路和 UAV-Sink 链路完成转发与汇聚。围绕这一过程，本文把运动约束、无线链路速率、覆盖关系、队列演化、功能性回传能力和能量消耗放入同一动态模型，并用归一化吞吐量、队列负载、能耗、覆盖违约和连通性违约构造综合目标函数。

      算法设计则从原始 L-SHADE 的两个短板切入：随机初始化没有使用任务节点空间信息，搜索早期容易覆盖不足；参数自适应主要依赖历史成功经验，缺少对 UAV 覆盖状态的显式感知，覆盖尚未稳定时可能过早转向性能优化。为此，本文提出覆盖状态感知 L-SHADE 算法。该算法保留 L-SHADE 的连续优化框架，在初始化阶段引入覆盖导向个体，在迭代阶段用种群覆盖状态约束参数变化。

      固定异构仿真环境下，原始 L-SHADE、覆盖优先初始化 L-SHADE 和覆盖状态感知 L-SHADE 的对比结果差异较明显。相较原始 L-SHADE，覆盖状态感知 L-SHADE 的平均覆盖率提高约 8.09%，归一化覆盖违约降低约 37.64%，吞吐量提高约 64.25%，队列负载降低约 19.64%。从收敛过程看，覆盖优先初始化主要缓解初始种群覆盖不足，覆盖状态感知参数控制则在中后期减少已有覆盖结构被差分扰动破坏的情况。
    ],
    keywords: ("异构无人机集群", "动态路由规划", "覆盖状态感知", "L-SHADE", "应急通信"),
  ),
  abstract-en: (
    content: [
      The heterogeneous unmanned aerial vehicle (UAV) swarm communication network is jointly accomplished by UAVs with different capabilities for coverage, forwarding and convergence tasks. Compared with isomorphic systems, the maximum speed, coverage radius, communication bandwidth, transmission power, cache capacity and energy capacity of each UAV are not the same, and the roles they play in the same task will also be different. When the cluster is working, the UAV-ground node link is responsible for covering the task area, the UAV-UAV link undertakes aerial forwarding, and the UAV-Sink link completes data aggregation. This type of network is commonly found in scenarios where infrastructure is restricted, such as temporary communication, regional monitoring, and post-disaster emergency communication.

      Dynamic route planning for heterogeneous UAV clusters is not a pure path selection. UAV flight trajectory will change the ground coverage and link transmission quality, and the link rate will affect the buffer queue drain. High-speed flights and high-power launches also speed up energy consumption. These factors are continuously transmitted along the time series, so the problem has the characteristics of high dimension, nonlinear, non-smooth and strong time series coupling. For such continuous optimization problems, general metaheuristics are often difficult to stably form coverage and backhaul capabilities if they do not take advantage of task structure. Based on this, this paper studies the dynamic route planning method of heterogeneous UAV swarm communication network.

      This paper focuses on one of the more common scenarios in post-disaster emergency communications: ground communication infrastructure is damaged, mission nodes continue to generate data, and the network needs to be reorganized quickly. In this scenario, routing planning cannot be equated with fixed path selection or single next-hop decision in traditional networks, but should be modeled together with UAV motion control, coverage relationship, link rate, and queue state. In this paper, the speed, heading Angle and transmit power of Uavs are used as joint optimization objects to maintain ground coverage and data return during the movement of the UAV swarm. In other words, the routing planning referred to in this paper is essentially a dynamic optimization problem for heterogeneous UAV control sequences. In the optimization, the coverage and backhaul are prioritized, and the system throughput, queue load and energy consumption are also taken into account.

      The model part starts from a fixed-height 2D emergency communication scenario. The system consists of multiple heterogeneous Uavs, several ground mission nodes and a fixed Sink node. After the UAV covers the task node, the data arrival is generated, and then the data is forwarded and aggregated through the UAV-UAV link and the UAV-sink link. Focusing on this process, we put motion constraint, wireless link rate, coverage relationship, queue evolution, functional backhaul capacity and energy consumption into the same dynamic model, and construct a comprehensive objective function by using normalized throughput, queue load, energy consumption, coverage violation and connectivity violation.

      The algorithm design starts from the two shortcomings of the original L-SHADE: random initialization does not use the spatial information of task nodes, and the early search is easy to cover insufficient. Parameter adaptation mainly relies on historical successful experience, lacks explicit perception of UAV coverage status, and may turn to performance optimization prematurely when the coverage is not stable. To this end, this paper proposes a coverage-state-aware L-SHADE algorithm. The algorithm retained the continuous optimization framework of L-SHADE, introduced cover-oriented individuals in the initialization phase, and constrained parameter changes with population coverage status in the iteration phase.

      In the fixed heterogeneous simulation environment, the comparison results of the original L-SHADE, the coverage-first initialized L-SHADE, and the coverage-state-aware L-SHADE are significantly different. Compared with the original L-SHADE, the average coverage rate of the coverage-state-aware L-SHADE is increased by about 8.09%, the normalized coverage violation is reduced by about 37.64%, the throughput is increased by about 64.25%, and the queue load is reduced by about 19.64%. From the perspective of the convergence process, the coverage priority initialization mainly alleviates the insufficient coverage of the initial population, and the coverage state aware parameter control reduces the damage of the existing coverage structure by differential disturbance in the middle and late stages.
      
    ],
    keywords: ("Heterogeneous UAV Swarm", "Dynamic Route Planning", "Coverage State Awareness", "L-SHADE", "Emergency Communication"),
  ),
  appendix: [
    #align(center)[*附录 A 完整符号表*]

    #heading(level: 2, numbering: none)[A.1 集合、索引与规模参数]

    #align(center)[表 A-1 集合、索引与规模参数]

    #three-line-table(
      columns: (auto, 1fr, auto),
      table.header([符号], [含义], [单位]),
      [$cal(U) = brace.l 1, 2, dots, N brace.r$], [UAV 节点集合], [-],
      [$cal(K) = brace.l 1, 2, dots, K brace.r$], [地面任务节点集合], [-],
      [$s$], [Sink 节点], [-],
      [$cal(V) = cal(U) union brace.l s brace.r$], [通信节点集合], [-],
      [$cal(T) = brace.l 0, 1, dots, T - 1 brace.r$], [离散时隙集合], [-],
      [$cal(G) = brace.l 0, 1, dots, G - 1 brace.r$], [控制段集合], [-],
      [$N$], [UAV 数量], [-],
      [$K$], [地面任务节点数量], [-],
      [$T$], [总时隙数], [-],
      [$L_c$], [单个控制段包含的时隙数], [-],
      [$G = ceil(T / L_c)$], [控制段总数], [-],
      [$D = 3 N G$], [单个候选解维度], [-],
      [$i, j$], [UAV 或通信节点索引], [-],
      [$k$], [地面任务节点索引], [-],
      [$t$], [时隙索引], [-],
      [$g$], [控制段索引], [-],
      [$cal(T)_g$], [第 $g$ 个控制段对应的时隙集合], [-],
    )

    其中，

    $
    cal(T)_g =
    brace.l
      g L_c,
      g L_c + 1,
      dots,
      min((g + 1) L_c - 1, T - 1)
    brace.r.
    $

    #heading(level: 2, numbering: none)[A.2 场景输入参数]

    #align(center)[表 A-2 场景输入参数]

    #three-line-table(
      columns: (auto, 1fr, auto),
      table.header([符号], [含义], [单位]),
      [$L$], [正方形任务区域边长], [m],
      [$Delta t$], [单个时隙长度], [s],
      [$bold(q)_k = [x_k^"g", y_k^"g"]^top$], [地面任务节点 $k$ 的位置], [m],
      [$bold(p)_s = [x_s, y_s]^top$], [Sink 节点位置], [m],
      [$bold(p)_i(0)$], [UAV $i$ 的初始位置], [m],
    )

    #heading(level: 2, numbering: none)[A.3 优化变量]

    #align(center)[表 A-3 优化变量]

    #three-line-table(
      columns: (auto, 1fr, auto),
      table.header([符号], [含义], [单位]),
      [$bold(u)_i(g)$], [UAV $i$ 在控制段 $g$ 的控制向量], [-],
      [$hat(v)_i(g)$], [UAV $i$ 在控制段 $g$ 的期望飞行速度], [m/s],
      [$hat(theta)_i(g)$], [UAV $i$ 在控制段 $g$ 的期望航向角], [rad],
      [$P_i^"tx"(g)$], [UAV $i$ 在控制段 $g$ 的发射功率], [W],
      [$bold(U)$], [完整优化变量集合], [-],
    )

    其中，

    $
    bold(u)_i(g)
    =
    [
      hat(v)_i(g),
      hat(theta)_i(g),
      P_i^"tx"(g)
    ],
    $

    $
    bold(U)
    =
    brace.l
      bold(u)_i(g)
      mid
      i in cal(U),
      g in cal(G)
    brace.r.
    $

    #heading(level: 2, numbering: none)[A.4 运动与安全参数]

    #align(center)[表 A-4 运动与安全参数]

    #three-line-table(
      columns: (auto, 1fr, auto),
      table.header([符号], [含义], [单位]),
      [$v_i^"max"$], [UAV $i$ 的最大飞行速度], [m/s],
      [$a^"max"$], [最大切向加速度], [m/s^2],
      [$Delta theta^"max"$], [单时隙最大航向变化角], [rad],
      [$omega^"max"$], [最大角速度], [rad/s],
      [$R^"min"$], [最小转弯半径], [m],
      [$d_"safe"$], [UAV 间最小安全距离], [m],
    )

    #heading(level: 2, numbering: none)[A.5 通信、覆盖与队列参数]

    #align(center)[表 A-5 通信、覆盖与队列参数]

    #three-line-table(
      columns: (auto, 1fr, auto),
      table.header([符号], [含义], [单位]),
      [$B_i$], [UAV $i$ 的通信带宽], [Hz],
      [$P_i^"max"$], [UAV $i$ 的最大发射功率], [W],
      [$beta_0$], [参考距离增益系数], [m^2],
      [$delta$], [信道增益修正项], [m^2],
      [$sigma^2$], [噪声功率], [W],
      [$R_i^"cov"$], [UAV $i$ 的覆盖半径], [m],
      [$lambda_k$], [地面任务节点 $k$ 的数据产生率], [bit/s],
      [$Q_i^"max"$], [UAV $i$ 的最大缓存容量], [bit],
      [$epsilon_"con"$], [最小数据泄放比例系数], [-],
    )

    #heading(level: 2, numbering: none)[A.6 能量参数]

    #align(center)[表 A-6 能量参数]

    #three-line-table(
      columns: (auto, 1fr, auto),
      table.header([符号], [含义], [单位]),
      [$E_i^"max"$], [UAV $i$ 的最大能量容量], [J],
      [$P_i^"hover"$], [UAV $i$ 的悬停功率], [W],
      [$c_(2, i)^"fly"$], [UAV $i$ 的速度平方项飞行功率系数], [W/(m/s)^2],
      [$c_(3, i)^"fly"$], [UAV $i$ 的速度立方项飞行功率系数], [W/(m/s)^3],
    )

    各 UAV 初始能量满足

    $
    E_i(0) = E_i^"max".
    $

    #heading(level: 2, numbering: none)[A.7 状态变量]

    #align(center)[表 A-7 状态变量]

    #three-line-table(
      columns: (auto, 1fr, auto),
      table.header([符号], [含义], [单位]),
      [$bold(p)_i(t) = [x_i(t), y_i(t)]^top$], [UAV $i$ 在时隙 $t$ 的二维位置], [m],
      [$v_i(t)$], [UAV $i$ 在时隙 $t$ 的实际执行速度], [m/s],
      [$phi_i(t)$], [UAV $i$ 在时隙 $t$ 的实际执行航向角], [rad],
      [$Q_i(t)$], [UAV $i$ 在时隙 $t$ 的缓存队列长度], [bit],
      [$E_i(t)$], [UAV $i$ 在时隙 $t$ 的剩余能量], [J],
    )

    #heading(level: 2, numbering: none)[A.8 通信、覆盖与队列中间量]

    #align(center)[表 A-8 通信、覆盖与队列中间量]

    #three-line-table(
      columns: (auto, 1fr, auto),
      table.header([符号], [含义], [单位]),
      [$d_(i j)(t)$], [UAV $i$ 与 UAV $j$ 在时隙 $t$ 的距离], [m],
      [$d_(i s)(t)$], [UAV $i$ 与 Sink 在时隙 $t$ 的距离], [m],
      [$d_(i k)^"g"(t)$], [UAV $i$ 与地面任务节点 $k$ 在时隙 $t$ 的距离], [m],
      [$g_(i j)(t)$], [链路 $i -> j$ 的信道增益], [-],
      [$gamma_(i j)(t)$], [链路 $i -> j$ 的信噪比], [-],
      [$r_(i j)(t)$], [链路 $i -> j$ 的数据传输速率], [bit/s],
      [$c_(i k)(t)$], [UAV $i$ 对地面任务节点 $k$ 的覆盖指示量], [-],
      [$z_k(t)$], [地面任务节点 $k$ 在时隙 $t$ 的覆盖状态], [-],
      [$A_i(t)$], [时隙 $t$ 进入 UAV $i$ 队列的数据量], [bit],
      [$F_i^"in"(t)$], [UAV $i$ 在时隙 $t$ 的等效转发流入量], [bit],
      [$F_i^"out"(t)$], [UAV $i$ 在时隙 $t$ 的等效转发流出量], [bit],
    )

    其中，

    $
    c_(i k)(t) in brace.l 0, 1 brace.r,
    quad
    z_k(t) in brace.l 0, 1 brace.r.
    $

    #heading(level: 2, numbering: none)[A.9 评价指标与目标函数符号]

    #align(center)[表 A-9 评价指标与目标函数符号]

    #three-line-table(
      columns: (auto, 1fr, auto),
      table.header([符号], [含义], [单位]),
      [$rho_"cov"$], [任务周期平均覆盖率], [-],
      [$R_"norm"$], [归一化系统吞吐量], [-],
      [$Q_"norm"$], [归一化队列负载], [-],
      [$E_"norm"$], [归一化能耗指标], [-],
      [$V_"cov"^"norm"$], [归一化覆盖违约指标], [-],
      [$V_"con"^"norm"$], [归一化连通性违约指标], [-],
      [$J_"perf"$], [通信性能评价项], [-],
      [$J_"total"$], [综合目标函数值], [-],
    )

    #heading(level: 2, numbering: none)[A.10 目标函数权重]

    #align(center)[表 A-10 目标函数权重]

    #three-line-table(
      columns: (auto, 1fr, auto),
      table.header([符号], [含义], [单位]),
      [$lambda_0$], [吞吐量指标权重], [-],
      [$lambda_1$], [队列指标权重], [-],
      [$lambda_2$], [能耗指标权重], [-],
      [$lambda_3$], [覆盖违约指标权重], [-],
      [$lambda_4$], [连通性违约指标权重], [-],
    )

    #pagebreak()
    #align(center)[*附录 B 实验补充参数设置*]

    #heading(level: 2, numbering: none)[B.1 通信模型参数]

    附录实验中的通信链路按视距条件计算，路径损耗采用二维距离平方衰减形式。参数取值见表 B-1。

    #align(center)[表 B-1 通信模型参数]

    #three-line-table(
      columns: (1fr, auto),
      table.header([参数], [数值]),
      [信道增益参数 $beta_0$], [$1 times 10^(-3)$],
      [噪声功率], [$1 times 10^(-9)$],
      [连通违约系数 $epsilon$], [0.1],
      [任务节点单时隙数据量], [$5 times 10^4$ bit],
    )

    #heading(level: 2, numbering: none)[B.2 UAV 动力学约束参数]

    运动部分沿用正文的固定高度二维模型。速度变化、转角限制和安全距离等取值见表 B-2。

    #align(center)[表 B-2 UAV 动力学约束参数]

    #three-line-table(
      columns: (1fr, auto),
      table.header([参数], [数值]),
      [安全距离 $D_"safe"$], [20 m],
      [最大加速度], [5 m/s^2],
      [最大转角], [30°],
      [最大角速度], [30°/s],
      [最小转弯半径], [30 m],
    )

    #heading(level: 2, numbering: none)[B.3 覆盖状态感知 L-SHADE 状态控制参数]

    覆盖状态感知 L-SHADE 采用覆盖状态感知参数控制机制，根据种群覆盖状态动态调整差分进化参数 $p / F / "CR"$。其状态机相关参数设置如表 B-3 所示。

    #align(center)[表 B-3 覆盖状态感知 L-SHADE 状态控制参数]

    #three-line-table(
      columns: (1fr, auto),
      table.header([参数], [数值]),
      [`elite_ratio`], [0.20],
      [$tau_H$], [0.15],
      [$tau_L$], [0.10],
      [$tau_"safe"$], [0.10],
      [$tau_"recover"$], [0.11],
      [$r_L$], [0.20],
      [$r_H$], [0.50],
      [$r_"recover"$], [0.40],
      [$delta_"stable"$], [0.002],
      [`hold_required`], [3],
    )

    覆盖状态感知 L-SHADE 在不同覆盖状态下采用不同的 $p / F / "CR"$ 取值范围，其参数配置如表 B-4 所示。

    #align(center)[表 B-4 不同覆盖状态下的参数配置]

    #three-line-table(
      columns: (auto, auto, auto, auto),
      table.header([状态], [$p$], [$F$ 范围], [$"CR"$ 范围]),
      [$S_1$], [0.08], [$[0.50, 0.80]$], [$[0.15, 0.40]$],
      [$S_2$], [0.10], [$[0.35, 0.60]$], [$[0.10, 0.30]$],
      [$S_3$], [0.15], [$[0.20, 0.50]$], [$[0.10, 0.35]$],
      [$S_4$], [0.08], [$[0.35, 0.60]$], [$[0.10, 0.25]$],
    )

    这里 $S_1$ 对应覆盖探索，$S_2$ 对应覆盖改进，$S_3$ 对应覆盖稳定，$S_4$ 对应覆盖恢复。
  ],
  acknowledgement: [
    致谢内容……
  ],
  design-summary: [
    本文围绕异构无人机集群通信网络动态路由规划问题，建立了包含 UAV 运动控制、无线通信、地面任务节点覆盖、数据队列、功能性回传能力和能量消耗的动态优化模型，并在 L-SHADE 基础上提出覆盖状态感知 L-SHADE 算法。覆盖优先初始化用于缓解随机初始化带来的低覆盖冷启动问题，覆盖状态感知参数控制则根据种群覆盖状态调整后续搜索行为。固定环境实验中，覆盖状态感知 L-SHADE 相较原始 L-SHADE 和覆盖优先初始化 L-SHADE 在综合目标值、覆盖率、覆盖违约、吞吐量、队列负载和能耗等指标上表现更稳。对异构 UAV 动态覆盖路由问题而言，把覆盖状态显式纳入搜索过程，比单纯依赖通用参数自适应更贴近任务结构。

  ],
)

= 绪论

== 研究背景与意义
无人机（Unmanned Aerial Vehicle, UAV）能够在地面条件受限时快速进入任务区域。灾情发生后，它可以搭载传感器和摄像设备，对受灾区域进行巡航观测，获得图像、视频和现场状态信息，为救援调度提供实时数据@HBGL202514005。问题在于，灾后通信任务并不只需要“飞到现场”。当地震、洪涝或山火破坏地面通信设施后，任务节点数据往往持续产生，甚至会在短时间内集中到达。UAV 覆盖没有及时建立，回传链路也没有成形时，缓存队列很快就会积压，随后带来时延升高、缓存紧张和数据丢失。UAV 通信网络路由规划因此要同时处理覆盖建立、队列演化和向 Sink 的持续回传。

UAV 通信网络不能简单看作航迹规划或静态部署问题。更贴近本文任务的理解，是把它看成轨迹控制、任务覆盖、链路传输、队列演化和能量消耗共同作用的动态优化问题@2024Evolutionary。UAV 的速度、航向角和位置变化决定其与地面任务节点、其他 UAV 及 Sink 节点之间的空间距离，并影响覆盖关系、信道增益和链路传输速率。覆盖状态决定地面数据能否进入 UAV 队列；队列能否及时泄放，又依赖 UAV–UAV 链路和 UAV–Sink 链路的回传能力。高速飞行和高功率发射还会加快能量消耗，剩余能量反过来限制后续运动和通信。单独优化某一个环节，很可能只是把压力转移到另一个环节@2024Evolutionary。多 UAV 协同场景下，异构性还会放大这种难度。不同 UAV 在最大速度、覆盖半径和初始能量等方面存在差异，统一控制策略或割裂式优化方法很难兼顾覆盖服务、数据回传和能量消耗@9417264。

该问题难在变量维度高、关系非线性、状态切换不光滑，且时间耦合很强。在时序演化过程中，当前控制量不会只影响当前收益，还会改变 UAV 位置、缓存队列和剩余能量，并继续作用于后续状态。覆盖关系具有阈值特征，距离变化可能引发离散切换；通信速率同时受信道衰减和发射功率约束。传统精确优化方法可以描述一部分约束，但建模过程较繁，求解成本较高，面对更大规模网络时扩展能力不足@2025UAV。本文不追求直接精确求解，而采用启发式或元启发式算法获得近似解@Das2026@AGRAWAL20241。

元启发式算法对目标函数解析形式要求较低，可以通过仿真评价处理复杂约束、黑箱目标和高维连续变量。对应到本文问题，候选解可以表示为 UAV 在多个控制段内的速度、航向角和发射功率序列，目标函数由完整动态仿真得到。该问题难以构造显式梯度或凸优化形式，更适合通过种群搜索筛选控制方案。覆盖违约、队列负载、能耗和回传能力等指标也可以放在同一评价框架内计算，便于将通信任务中的多个约束纳入搜索过程。

在多类元启发式算法中，差分进化及其改进算法更贴近本文这类连续变量、高维和复杂约束优化问题。差分进化基于种群差分向量生成搜索方向，不依赖目标函数梯度，适合 UAV 控制序列这类实数编码问题。与更偏离散路径编码的算法相比，差分进化便于同时处理速度、航向角和发射功率；与单粒子式或局部搜索方法相比，其种群机制有助于维持多样性，降低陷入局部覆盖模式的风险。基于这些特点，本文选择差分进化框架作为动态覆盖路由优化的基础。

L-SHADE@LI2022350 的优势在于，它把 SHADE@6900380 的成功历史参数记忆与线性种群规模缩减结合起来：搜索前期保留较多候选解，后期再逐步压缩种群以节省计算量。把它直接用于本文问题时，短板也比较明显。算法记住的是哪些 $F$ 和 $"CR"$ 曾带来适应度改进，却不知道这些改进发生在覆盖尚未形成、覆盖刚稳定，还是已经进入性能细化的阶段。对动态覆盖路由而言，覆盖状态一变，地面数据到达、队列泄放和 Sink 侧回传都会跟着变化。因此，本文在 L-SHADE 框架中显式引入 UAV 覆盖结构信息，让搜索行为能够随覆盖构造、稳定保持和性能精修三个过程调整。

== 国内外研究现状
=== UAV 通信网络与动态路由规划研究
UAV 通信网络以无人机作为空中节点，主要依靠 UAV–地面节点链路、UAV–UAV 链路和 UAV–Sink 链路完成临时通信@HNLG202512002。早期研究更关注单架 UAV，典型问题包括位置部署、轨迹规划和空地信道建模@1025020518.nh，优化目标多集中在覆盖范围、通信速率和飞行能耗。应急通信任务通常需要多架 UAV 协同工作，研究重点也从单机轨迹逐渐转向协同路径规划、覆盖控制、数据回传和资源分配。

覆盖范围扩大后，回传压力也会增加。UAV 需要先覆盖任务节点，采集到的数据还要经 UAV–UAV 或 UAV–Sink 链路传回 Sink。单纯追求覆盖率会推动 UAV 分散部署，分散部署容易拉长回传链路并降低链路质量；UAV 过度聚集虽然有利于回传，但边缘区域可能覆盖不足@10535707。覆盖和回传必须放在同一模型中考虑，这是 UAV 应急通信规划中的难点@2024Evolutionary。

在 UAV 网络结构建模中，已有研究常引入图论连通、通信半径和 k-连通约束@1024503963.nh，也有工作使用流约束或链路可靠性描述节点间连接关系@1022589382.nh。这些方法能够描述拓扑可达性，但动态任务还要回答另一个问题：数据能不能稳定传回 Sink。链路速率、UAV 队列状态和 Sink 汇聚能力都会影响实际回传效果。只判断拓扑是否连通，无法解释队列如何积压、数据如何传出。

近年的 UAV 路径与路由研究已经不再局限于几何路径本身，轨迹、链路、功率、队列和能耗往往会同时进入优化目标。不过，两类工作之间仍有空隙：协议层路由更关心下一跳和链路维护，对连续运动控制关注较少@10041916；轨迹优化虽然会纳入通信速率或能耗，却不一定追踪覆盖状态如何改变数据到达和队列稳定性@ELNABTY2022101564。本文把问题放在动态覆盖路由视角下处理，核心是让 UAV 控制、覆盖状态、链路速率和队列演化在同一时域模型里相互作用。

=== 元启发式算法
UAV 路径规划、覆盖优化和通信资源分配往往约束较多，目标函数也不容易写成可求梯度的形式，因此元启发式算法在相关研究中使用较多。不过，算法类型和问题编码之间并不能简单对应。GA 通过选择、交叉和变异更新种群，在节点访问顺序、任务分配等离散编码问题中较常见，但其参数设置和收敛速度会影响最终解质量@湛文静2023基于改进遗传算法的路径规划问题相关研究综述。PSO 的结构更轻，适合不少静态连续优化问题；放到动态系统跟踪任务中时，粒子过早聚集会使搜索稳定性下降@刘秀梅2016动态系统中粒子群优化算法综述。本文的控制变量是速度、航向角和发射功率，天然属于实数编码。DE 使用种群差分向量产生新候选解，参数数量较少，也便于和连续控制序列相结合@ZNXT201704001。相比之下，DE 更适合作为本文 UAV 动态覆盖路由优化的基础算法。

围绕 DE 的改进，研究者主要从参数控制、差分策略、种群结构和混合搜索几个方向展开。L-SHADE 是本文重点采用的一类改进算法@LI2022350。它的参数更新并不是每次都重新人工指定，而是把产生成功试验个体的 $F$ 和 $"CR"$ 写入历史记忆，再从这些记忆中采样新的控制参数。与此同时，线性种群规模缩减使算法在前期保留较宽的搜索范围，后期逐步减少个体数量。这样处理后，L-SHADE 在连续变量和高维黑箱优化中通常能取得较稳的结果，也为本文后续加入覆盖状态约束留下了接口。

=== 现有研究不足
从现有研究看，UAV 通信网络动态路由规划仍有若干问题没有处理充分。围绕 UAV 轨迹、发射功率、吞吐量和能耗，已有研究开展了较多联合优化工作；也有研究把动态任务到达和队列稳定性纳入 UAV 轨迹或资源优化模型@7888557。这类工作多集中在通信资源分配、MEC 卸载和吞吐最大化上，对覆盖状态、数据到达、队列演化和 Sink 回传能力之间反馈关系的刻画仍然不够清晰。

现有 FANET 路由研究主要聚焦协议层。常见方法包括拓扑路由、位置路由、分簇路由、DTN 路由和策略型路由。这些方法主要处理动态拓扑中的数据包转发、下一跳选择和链路维护@10041916。这类方法可用于协议层路由优化。本文研究对象不同，重点是规划层动态控制任务。因此，模型还需描述 UAV 连续控制、链路速率变化和队列泄放过程。

L-SHADE 沿用 SHADE 的成功历史参数记忆机制@6900380，并通过线性种群规模缩减控制搜索开销@LI2022350。已有 UAV 资源配置研究说明，这类机制可以处理较高维的连续变量。放到本文任务中，问题出在反馈信息不够具体：原始 L-SHADE 只知道某次试验是否改善适应度，却不知道改善背后是覆盖变好、队列变短，还是能耗偶然降低。当覆盖结构还没有形成，或者已经被差分扰动破坏时，单靠历史成功参数很难及时把搜索拉回覆盖可行区域。

== 本文主要研究内容
围绕异构无人机集群通信网络动态路由规划问题，本文主要做了模型、算法和实验三部分工作。

模型部分，本文考虑由多架异构 UAV、若干地面任务节点和固定 Sink 节点构成的通信网络，建立 UAV 运动模型、无线通信模型、地面节点覆盖模型、数据队列与功能性连通表征模型以及能量消耗模型。在此基础上，将系统吞吐量、队列负载、能量消耗、覆盖违约和连通违约纳入同一目标函数，形成面向 UAV 控制序列的动态优化问题。

种群生成阶段，本文引入覆盖优先初始化机制。原始 L-SHADE 初始种群主要随机生成，任务节点分布未参与初始化过程，早期搜索容易落入低覆盖区域。本文据此生成部分覆盖导向初始个体，使初始控制序列更快接近任务节点区域，并保留基本覆盖结构，减少低覆盖无效搜索。

搜索阶段则引入覆盖状态指标，用来调节 L-SHADE 的参数。这里不再把整段搜索过程看成同一种状态：覆盖尚未形成时需要更强的探索，覆盖刚形成时要避免结构被打散，覆盖较稳定后才适合把更多精力放到吞吐、队列和能耗上；一旦覆盖退化，还要切回恢复策略。

实验部分，本文在固定环境下对原始 L-SHADE、覆盖优先初始化 L-SHADE 和覆盖状态感知 L-SHADE 进行多次独立运行，从综合目标值、覆盖率、覆盖违约、连通违约、吞吐量、队列负载和能耗等指标比较算法表现，并结合收敛曲线和结果分布分析改进机制的作用。
== 本文组织结构
全文共六章，安排如下。

第 1 章为绪论，说明研究背景与意义，梳理 UAV 通信网络、动态路由规划和元启发式算法相关研究，并给出本文工作内容与章节安排。

第 2 章为相关理论与技术基础，介绍无人机通信网络组成、覆盖与连通表征、动态路由规划问题界定，以及差分进化与 L-SHADE 的基本机制。

第 3 章为异构无人机集群通信网络动态路由规划模型，构建 UAV 运动、无线通信、覆盖、队列、连通性表征、能耗和综合目标函数模型，并给出问题形式化描述。

第 4 章为覆盖状态感知 L-SHADE 路由优化算法，分析原始 L-SHADE 在本文问题中的不足，提出覆盖优先初始化和覆盖状态感知参数控制机制，并给出算法流程与复杂度分析。

第 5 章为仿真实验与结果分析，基于固定环境实验对原始 L-SHADE、覆盖优先初始化 L-SHADE 和覆盖状态感知 L-SHADE 进行对比，分析不同算法在综合目标、覆盖率、覆盖违约、吞吐量、队列负载和能耗等指标上的表现。

第 6 章为总结与展望，概括本文主要工作，并讨论当前模型和算法仍需改进的方向。
= 相关理论与技术基础

本章先交代后续建模和算法设计要用到的几个基础概念。无人机通信网络的节点组成、链路关系和异构参数，是第 3 章场景建模的入口；覆盖、连通和功能性回传能力，则关系到模型如何判断任务服务是否完成。章末再介绍差分进化与 L-SHADE，因为后续覆盖状态感知 L-SHADE 的改进仍在这些基础机制上展开，并不另起一个优化框架。

== 无人机通信网络基本组成
本文的网络由空中 UAV、地面任务节点和固定 Sink 组成。UAV 在任务区内移动，既要让地面节点进入服务范围，也要把已经采集的数据继续向后转发；地面任务节点持续产生待回传数据；Sink 只作为汇聚端接收结果。后续模型保留三类链路：UAV–任务节点链路对应数据采集，UAV–UAV 链路对应空中中继，UAV–Sink 链路对应末端回传。

任务节点能否接入网络，取决于 UAV–任务节点链路。这条链路既决定覆盖关系，也决定数据是否进入 UAV 队列。多 UAV 之间的数据传递依靠 UAV–UAV 链路，最终面向 Sink 的回传依赖 UAV–Sink 链路。与固定通信网络不同，UAV 会持续移动；位置一变，链路距离、信道增益和传输速率也跟着变化。建模时如果只看节点是否相连，数据传输质量和队列积压很容易被遮住。

本文所建 UAV 集群由异构节点组成。异构 UAV 在最大速度、覆盖半径、通信带宽、发射功率、缓存容量和初始能量上存在差异。这些参数差异会影响覆盖、巡航、中继和回传任务分工。后续模型将保留这些异构参数，使控制序列能够体现各 UAV 能力边界。

== 覆盖与连通表征
在模型中，覆盖主要表示地面任务节点是否处于 UAV 服务范围内。已有模型通常从距离或信道条件出发判断覆盖。距离模型更简洁，信道模型则更关注通信质量。本文用距离阈值判断覆盖。当 UAV 与地面任务节点距离小于或等于其覆盖半径时，该节点视为已被覆盖。在此基础上，本文统计任务周期平均覆盖率，并计算覆盖违约程度。

在传统图论框架中，连通性强调节点之间是否可达。对应到 UAV 网络中，就是判断拓扑是否连通。本文关注动态通信任务。此时，节点可达只能说明路径存在，不能保证数据稳定传回 Sink。拓扑路径存在，并不代表回传能力充足。若 UAV–Sink 链路速率较低，或 UAV 队列长期积压，系统仍可能无法完成稳定回传。本文的重点转向数据回传效果，即数据能否持续、稳定地汇聚到 Sink。

功能性回传能力正是为这个问题设置的。它看的是 UAV 队列中的数据能否及时到达 Sink，而不是只判断链路是否存在。UAV–UAV 链路、UAV–Sink 链路、传输速率和队列负载都会影响回传效果。后文用 Sink 汇聚速率描述回传能力，用系统队列负载和回传能力违约反映积压风险。这样，连通性评价才和动态 UAV 通信任务中的数据流动对应起来。
== 动态路由规划问题界定
传统通信网络中的路由更偏向协议层转发，主要回答数据包走哪条路径、下一跳节点如何选择。UAV 通信网络的情况要复杂一些：节点位置持续变化，轨迹又会改变链路质量、覆盖关系和回传能力。本文讨论的动态路由规划不只是在已有拓扑上选路径，还要同时处理速度控制、航向调整和功率分配。

本文所称“动态路由规划”，不同于协议层路由表更新。它也不以逐包下一跳决策为核心。本文优化对象是 UAV 控制序列。控制序列包含各控制段的速度、航向角和发射功率。这些变量会改变 UAV 空间分布、覆盖关系和链路速率。经过上述建模，路由问题可表述为两项任务：在任务周期内维持覆盖，并持续向 Sink 回传数据。

这一问题可以看成“轨迹控制—覆盖服务—链路回传—队列稳定”的联合过程。UAV 的运动控制改变覆盖关系和链路距离，覆盖关系决定地面任务数据是否进入 UAV 队列，链路速率影响队列泄放，队列状态再反馈到系统性能评价。动态路由规划的重点不是找到一条固定路径，而是让 UAV 网络在整个时域内维持服务和回传能力。

据此，优化变量设为 UAV 分段控制序列。一个候选解对应一组完整控制方案，包括各 UAV 在不同控制段内的速度、航向角和发射功率。控制序列输入动态仿真后，模型返回覆盖率、吞吐量、队列负载、能耗和违约指标。动态路由规划由此转成高维连续优化问题，L-SHADE 及其改进算法也有了使用前提。
== 差分进化算法与 L-SHADE
DE 是基于实数编码的进化算法，常用于连续变量优化问题@ZNXT201704001。算法从随机初始种群出发，通过变异、交叉和选择更新个体。差分变异利用种群中个体之间的差分向量生成新候选解，交叉操作决定新旧个体如何组合，选择操作保留表现更好的个体。DE 不需要目标函数梯度，因此可以处理非线性、不可导和黑箱优化场景。

缩放因子 $F$、交叉概率 $"CR"$ 和种群规模会直接影响 DE 的搜索行为。$F$ 决定差分变异强度，取值较高时搜索范围更大，但也容易带来震荡；取值较低时更利于局部细化，却可能收缩过早。$"CR"$ 控制交叉更新范围，较高值会推动更多维度变化，较低值会保留更多原个体信息。许多 DE 改进工作都从这些参数的自动调整入手。

SHADE（Success-History based Adaptive Differential Evolution）@6900380 在 DE 中加入成功历史经验记忆。简单说，若某次变异和交叉产生的参数带来更好的试验个体，相关参数就会被存入历史集合，并在后续迭代中参与新参数生成。L-SHADE（Linear Population Size Reduction Success-History based Adaptive DE）@LI2022350 又加入线性种群规模缩减（LPSR），让种群规模随迭代逐步变小。前期保留较大种群，用来维持搜索范围；后期减少个体数量，用来降低计算开销并加快收敛。算法迭代中，DE/current-to-pbest/1 变异策略利用较优个体和差分向量共同生成搜索方向，外部存档则保存被淘汰个体，用来补充变异向量来源。

选择 L-SHADE 的主要原因，是 UAV 动态路由规划可以自然写成高维连续控制向量，而目标值又依赖完整仿真，解析梯度很难直接取得。问题也随之出现：原始 L-SHADE 的初始化、变异和参数控制都偏通用，并不会主动读取 UAV 覆盖状态。要让它服务于动态覆盖路由，还需要把任务节点分布、覆盖结构和回传状态引入初始化与参数控制环节。

== 章节小结

本章主要为后续建模和算法设计铺垫概念基础。先说明空中 UAV、地面任务节点和 Sink 节点各自承担的功能，再把动态路由规划中需要观察的网络状态落到覆盖、连通和功能性回传能力三个方面。本文讨论的路由问题以UAV 控制序列为优化对象，同时处理速度控制、航向调整和功率分配，而非固定拓扑上的路径选择。UAV 一旦移动，网络空间结构、无线链路质量、任务节点覆盖情况和队列回传过程都会随之变化，因此后续模型必须同时描述位置演化和数据流动。

算法部分介绍了差分进化及 L-SHADE 的基本思想。L-SHADE 适合处理连续控制变量，也不要求目标函数具有解析梯度，这正与实验的动态仿真评价方式相匹配。不过，L-SHADE 主要根据适应度反馈推进搜索，对任务节点分布和覆盖状态没有直接感知。这揭示后续工作的重点：在模型建立中，把 UAV 运动、覆盖、通信、队列和能耗之间的耦合关系梳理清晰；算法在原有基础上，需要加入面向覆盖路由的引导信息。

= 异构无人机集群通信网络动态路由规划模型

本章给出异构无人机集群通信网络动态路由规划问题的数学模型。模型面向固定高度二维应急通信场景，从系统节点、任务区域和基本假设写起，再描述 UAV 运动、无线通信、地面节点覆盖、数据队列与连通性表征、能量消耗等子模型。章末把这些模型合并到综合目标函数和约束描述中，将 UAV 的速度、航向角和发射功率联合控制转化为后续算法可处理的连续优化问题。

== 系统场景与基本假设
本文不考虑 UAV 高度变化，而将应急通信场景投影到二维平面中。本文用正方形区域表示任务范围。其边长为 $L$，区域坐标为 $Omega = [0, L] times [0, L]$，实验取值为 $L = 1000 "m"$。任务区域中设置$K$ 个地面任务节点，其位置保持不变。同时，区域内包含$N$架异构 UAV 和一个固定 Sink 节点 $s$。各地面节点持续产生回传数据。模型暂不设置业务优先级，使分析重点集中在覆盖建立和数据回传过程上。Sink 节点设置在任务区域中心，功能限定为接收汇聚数据。

系统数据流从地面任务节点开始。UAV 完成覆盖与采集后，数据通过 UAV–UAV 链路中继，并最终经 UAV–Sink 链路汇聚到 Sink。UAV 个体能力并不一致。差异主要体现在最大速度、覆盖半径、通信带宽、最大发射功率、缓存容量和能量容量上。由此，各 UAV 在覆盖、巡航、中继和回传任务中的适配角色也不同。

时间轴按时隙展开，$t = 0, 1, dots, T - 1$，每个时隙长度为 $Delta t$。UAV 不调整高度，只在水平平面内移动。控制量包括飞行速度、期望航向角和发射功率；采用分段常量控制后，同一控制段内保持同一组控制量。真正执行时，这组控制量还会受到速度、加速度、转角、角速度、转弯半径以及 UAV 间安全距离的限制。

当地面任务节点进入 UAV 有效覆盖范围后，该节点产生的数据进入对应 UAV 缓存队列。之后，数据经 UAV 间链路逐跳转发，最终通过 UAV-Sink 链路到达 Sink。本文所称动态路由规划，是在 UAV 位置、链路状态和队列状态持续变化的条件下，联合规划 UAV 运动控制与传输资源，使网络形成面向 Sink 的多跳数据传输过程。

为降低模型复杂度，本文采用如下基本假设：任务区域为二维正方形区域，地面任务节点位置固定；各地面任务节点数据产生率相同，不区分业务优先级；UAV 保持固定飞行高度，仅在二维平面内运动；UAV 与地面任务节点之间为视距通信，信道模型采用距离衰减形式；每架 UAV 有有限缓存，未转发数据暂存于本地队列；Sink 为固定地面汇聚节点，只接收数据，不参与转发；UAV 能耗由飞行能耗和通信发射能耗组成；UAV 之间保持不小于给定安全距离；任务区域给出地面节点、Sink 和 UAV 初始位置，UAV 可行行为由运动学、通信、能量和安全距离约束共同限定。

== 核心符号与变量定义

正文中只保留后续建模、算法编码和复杂度分析反复使用的核心符号，避免符号表打断模型推导。完整参数、中间变量和派生量统一放在附录 A。

=== 规模参数与索引

#align(center)[表 3-1 规模参数与索引说明]

#three-line-table(
  columns: (auto, 1fr, auto),
  table.header([符号], [含义], [单位]),
  [$cal(U) = brace.l 1, 2, dots, N brace.r$], [UAV 节点集合], [-],
  [$cal(K) = brace.l 1, 2, dots, K brace.r$], [地面任务节点集合], [-],
  [$s$], [Sink 节点], [-],
  [$cal(V) = cal(U) union brace.l s brace.r$], [通信节点集合], [-],
  [$cal(T) = brace.l 0, 1, dots, T - 1 brace.r$], [离散时隙集合], [-],
  [$cal(G) = brace.l 0, 1, dots, G - 1 brace.r$], [控制段集合], [-],
  [$N$], [UAV 数量], [-],
  [$K$], [地面任务节点数量], [-],
  [$T$], [总时隙数], [-],
  [$L_c$], [单个控制段包含的时隙数], [-],
  [$G$], [控制段总数], [-],
  [$D$], [单个候选解维度], [-],
  [$i, j$], [UAV 或通信节点索引], [-],
  [$k$], [地面任务节点索引], [-],
  [$t$], [时隙索引], [-],
  [$g$], [控制段索引], [-],
)

控制段总数为

$
G = ceil(T / L_c).
$

每架 UAV 在每个控制段内包含期望速度、期望航向角和发射功率 3 个控制量，因此单个候选解维度为

$
D = 3 N G.
$

=== 场景输入与优化变量

#align(center)[表 3-2 场景输入参数]

#three-line-table(
  columns: (auto, 1fr, auto),
  table.header([符号], [含义], [单位]),
  [$L$], [正方形任务区域边长], [m],
  [$Delta t$], [单个时隙长度], [s],
  [$bold(q)_k = [x_k^"g", y_k^"g"]^top$], [地面任务节点 $k$ 的位置], [m],
  [$bold(p)_s = [x_s, y_s]^top$], [Sink 节点位置], [m],
  [$bold(p)_i(0)$], [UAV $i$ 的初始位置], [m],
)

本文以控制段为单位优化 UAV 控制量。对于任意 $i in cal(U)$ 和 $g in cal(G)$，定义

$
bold(u)_i(g) =
[
  hat(v)_i(g),
  hat(theta)_i(g),
  P_i^"tx"(g)
].
$

其中 $hat(v)_i(g)$ 为期望飞行速度，$hat(theta)_i(g)$ 为期望航向角，$P_i^"tx"(g)$ 为发射功率。整体优化变量为

$
bold(U) =
brace.l
  bold(u)_i(g)
  mid
  i in cal(U),
  g in cal(G)
brace.r.
$

控制变量满足

$
0 <= hat(v)_i(g) <= v_i^"max",
$

$
0 <= hat(theta)_i(g) < 2 pi,
$

$
0 <= P_i^"tx"(g) <= P_i^"max".
$

=== 关键模型参数

#align(center)[表 3-3 关键模型参数]

#three-line-table(
  columns: (auto, 1fr, auto),
  table.header([符号], [含义], [单位]),
  [$v_i^"max"$], [UAV $i$ 的最大飞行速度], [m/s],
  [$P_i^"max"$], [UAV $i$ 的最大发射功率], [W],
  [$R_i^"cov"$], [UAV $i$ 的覆盖半径], [m],
  [$B_i$], [UAV $i$ 的通信带宽], [Hz],
  [$Q_i^"max"$], [UAV $i$ 的最大缓存容量], [bit],
  [$E_i^"max"$], [UAV $i$ 的最大能量容量], [J],
  [$d_"safe"$], [UAV 间最小安全距离], [m],
  [$epsilon_"con"$], [最小数据泄放比例系数], [-],
  [$lambda_0, lambda_1, lambda_2, lambda_3, lambda_4$], [综合目标函数权重], [-],
)

其中，不同 UAV 可具有不同的 $v_i^"max"$、$P_i^"max"$、$R_i^"cov"$、$B_i$、$Q_i^"max"$ 和 $E_i^"max"$，用于描述 UAV 集群的异构性。

=== 主要状态量与评价输出

#align(center)[表 3-4 主要状态量与评价输出]

#three-line-table(
  columns: (auto, 1fr, auto),
  table.header([符号], [含义], [单位]),
  [$bold(p)_i(t)$], [UAV $i$ 在时隙 $t$ 的二维位置], [m],
  [$v_i(t)$], [UAV $i$ 在时隙 $t$ 的实际执行速度], [m/s],
  [$phi_i(t)$], [UAV $i$ 在时隙 $t$ 的实际执行航向角], [rad],
  [$Q_i(t)$], [UAV $i$ 在时隙 $t$ 的缓存队列长度], [bit],
  [$E_i(t)$], [UAV $i$ 在时隙 $t$ 的剩余能量], [J],

  [$J_"perf"$], [通信性能评价项], [-],
  [$J_"total"$], [综合目标函数值], [-],
)

上述评价输出量由完整任务周期仿真得到，用于个体排序、层级判优、覆盖状态估计和最优解输出。

== 无人机运动模型

高度固定后，运动递推只发生在水平平面内。对 UAV $i$ 而言，时隙 $t$ 的状态向量记为

$
bold(s)_i(t)
=
[
  x_i(t),
  y_i(t),
  v_i(t),
  phi_i(t)
]^top.
$

其中，$bold(p)_i(t) = [x_i(t), y_i(t)]^top$ 为二维位置，$v_i(t)$ 为实际执行速度，$phi_i(t)$ 为实际执行航向角。初始速度和初始航向设为

$
v_i(0) = 0,
quad
phi_i(0) = 0.
$

系统以控制段为单位给出期望控制量。对于任意 $t in cal(T)_g$，UAV $i$ 接收控制段 $g$ 内的期望速度 $hat(v)_i(g)$ 和期望航向角 $hat(theta)_i(g)$。实际执行速度由期望速度、最大速度和最大切向加速度共同确定：

$
v_i(t)
=
op("clip")(
  hat(v)_i(g),
  max(0, v_i(t - 1) - a^"max" Delta t),
  min(v_i^"max", v_i(t - 1) + a^"max" Delta t)
).
$

并满足

$
0 <= v_i(t) <= v_i^"max".
$

这里的 $op("clip")(x, l, u)$ 用来把 $x$ 限制在区间 $[l, u]$ 内。

控制段 $g$ 给出期望绝对航向 $hat(theta)_i(g)$。角度存在周期性，直接相减可能把一次很小的转向误写成接近 $2 pi$ 的大转向，因此先计算它相对上一时隙实际航向的最短角差：

$
delta_i(t)
=
op("wrap")_([-pi, pi])
(
  hat(theta)_i(g) - phi_i(t - 1)
).
$

单时隙内允许的航向变化量与当前速度有关。若 $v_i(t) > 0$，转角还要受最小转弯半径约束：

$
Delta phi_i^"max"(t)
=
min(
  Delta theta^"max",
  omega^"max" Delta t,
  (v_i(t) Delta t) / R^"min"
).
$

当 $v_i(t) = 0$ 时，

$
Delta phi_i^"max"(t)
=
min(
  Delta theta^"max",
  omega^"max" Delta t
).
$

实际执行转角为

$
delta_i^"exe"(t)
=
op("clip")(
  delta_i(t),
  -Delta phi_i^"max"(t),
  Delta phi_i^"max"(t)
).
$

实际执行航向角更新为

$
phi_i(t)
=
op("wrap")_([0, 2 pi))
(
  phi_i(t - 1) + delta_i^"exe"(t)
).
$

其中，$op("wrap")_([-pi, pi]) (dot)$ 和 $op("wrap")_([0, 2 pi)) (dot)$ 分别表示角度区间映射函数。

实际速度 $v_i(t)$ 和航向 $phi_i(t)$ 确定以后，先按离散运动方程得到下一时隙候选位置：

$
tilde(bold(p))_i(t + 1)
=
bold(p)_i(t)
+
v_i(t) Delta t
[
  cos phi_i(t),
  sin phi_i(t)
]^top.
$

等价地，

$
tilde(x)_i(t + 1)
=
x_i(t) + v_i(t) Delta t cos phi_i(t),
$

$
tilde(y)_i(t + 1)
=
y_i(t) + v_i(t) Delta t sin phi_i(t).
$

UAV 之间还要保留安全间隔。任意两架 UAV 的距离需满足：

$
norm(bold(p)_i(t) - bold(p)_j(t))_2
>=
d_"safe",
quad
forall i, j in cal(U),
i != j.
$

候选位置生成后再做安全距离检查。若某个 $j != i$ 与 UAV $i$ 的候选位置距离小于阈值，

$
norm(tilde(bold(p))_i(t + 1) - tilde(bold(p))_j(t + 1))_2
<
d_"safe",
$

则取消 UAV $i$ 当前时隙的位移更新，并将其实际执行速度置零：

$
bold(p)_i(t + 1) = bold(p)_i(t),
quad
v_i(t) = 0.
$

否则，接受候选位置：

$
bold(p)_i(t + 1) = tilde(bold(p))_i(t + 1).
$

速度、航向和位置经过约束修正后，模型确定 UAV 状态量。具体包括位置  $bold(p)_i(t)$、速度$v_i(t)$和航向角 $phi_i(t)$。上述状态量将继续用于通信距离计算、覆盖判定和飞行能耗评估。

== 无线通信模型

数据回传有两条可能路径：先转发给其他 UAV，或直接传给 Sink。为减少重复记号，接收端统一写成 $j in cal(V) = cal(U) union brace.l s brace.r$。当 $j in cal(U)$ 时，对应 UAV-UAV 转发链路；当 $j = s$ 时，对应 UAV-Sink 汇聚链路。链路假设为视距通信，暂不考虑同频干扰、多径衰落和 LoS/NLoS 随机切换。若接收端是 UAV，其位置为 $bold(p)_j(t)$；若接收端是 Sink，则位置为固定的 $bold(p)_s$。

则链路距离为

$
d_(i j)(t)
=
norm(bold(p)_i(t) - bold(p)_j(t))_2,
quad
i in cal(U),
j in cal(V),
i != j.
$

链路信道增益采用距离平方衰减模型：

$
g_(i j)(t)
=
beta_0 / (d_(i j)^2(t) + delta),
quad
i in cal(U),
j in cal(V),
i != j.
$

其中，$beta_0$ 为参考距离增益系数，$delta$ 为信道增益修正项。

链路 $i -> j$ 在时隙 $t$ 的信噪比为

$
gamma_(i j)(t)
=
(P_i^"tx"(t) g_(i j)(t)) / sigma^2,
$

其中，$P_i^"tx"(t)$ 为 UAV $i$ 的发射功率，$sigma^2$ 为噪声功率。相应的可达传输速率为

$
r_(i j)(t)
=
B_i log_2(1 + gamma_(i j)(t)),
quad
i in cal(U),
j in cal(V),
i != j.
$

等价地，

$
r_(i j)(t)
=
B_i log_2(
  1 + (P_i^"tx"(t) g_(i j)(t)) / sigma^2
).
$

其中，$B_i$ 为发送 UAV $i$ 的通信带宽。对于 UAV 自身到自身的无效链路，规定

$
r_(i i)(t) = 0,
quad
i in cal(U).
$

为统一表示各时隙内的链路传输能力，定义速率矩阵

$
bold(R)(t)
=
[r_(i j)(t)]_(i in cal(U), j in cal(V))
in
RR^(N times (N + 1)).
$

其中，$j in cal(U)$ 对应 UAV-UAV 转发速率，$j = s$ 对应 UAV-Sink 汇聚速率。后续队列模型基于 $bold(R)(t)$ 计算 UAV 间等效转发流量和 Sink 侧数据泄放能力。

== 地面节点覆盖模型

为刻画 UAV 对地面任务节点的数据采集条件，定义时隙 $t$ 内 UAV $i in cal(U)$ 与地面任务节点 $k in cal(K)$ 的二维距离为

$
d_(i k)^"g"(t)
=
norm(bold(p)_i(t) - bold(q)_k)_2.
$

考虑 UAV 覆盖半径 $R_i^"cov"$，二元覆盖指示量定义为

$
c_(i k)(t)
=
bb(I)(
  d_(i k)^"g"(t) <= R_i^"cov"
),
quad
i in cal(U),
k in cal(K),
t in cal(T),
$

其中，$bb(I)(dot)$ 为示性函数。任务节点 $k$ 在时隙 $t$ 的覆盖状态为

$
z_k(t)
=
min(
  1,
  sum_(i in cal(U)) c_(i k)(t)
).
$

据此，系统在时隙 $t$ 的覆盖率和整个任务周期内的平均覆盖率分别为

$
rho_"cov"(t)
=
1 / K
sum_(k in cal(K)) z_k(t),
$

$
rho_"cov"
=
1 / T
sum_(t in cal(T)) rho_"cov"(t)
=
1 / (T K)
sum_(t in cal(T))
sum_(k in cal(K))
z_k(t).
$

覆盖不足程度由覆盖违约量表示。时隙 $t$ 的覆盖违约量定义为

$
V_"cov"(t)
=
sum_(k in cal(K))
(1 - z_k(t)).
$

累计覆盖违约量为

$
V_"cov"^"sum"
=
sum_(t in cal(T))
V_"cov"(t).
$

归一化覆盖违约指标为

$
V_"cov"^"norm"
=
V_"cov"^"sum" / (T K).
$

在上述定义下，有

$
V_"cov"^"norm"
=
1 - rho_"cov".
$

本文不将任意时隙全覆盖作为硬约束，而以 $V_"cov"^"norm"$ 量化覆盖不足。该指标将进入综合目标函数，并用于第 4 章算法层级判优和覆盖状态感知参数控制。

== 数据队列与连通性表征模型

数据从地面节点进入 UAV 后，还需要沿链路继续向 Sink 泄放。这里用链路速率驱动 UAV 缓存队列更新；所谓连通性，也指缓存数据能否被持续送回 Sink 的功能性能力，而不是静态图上的全连通。

*数据到达量。* 地面任务节点 $k$ 在单个时隙内产生的数据量为

$
a_k = lambda_k Delta t.
$

若任务节点 $k$ 处于 UAV $i$ 的覆盖范围内，即 $c_(i k)(t) = 1$，则其数据进入 UAV $i$ 的缓存队列。UAV $i$ 在时隙 $t$ 的地面数据到达量为

$
A_i(t)
=
sum_(k in cal(K)) c_(i k)(t) a_k
=
sum_(k in cal(K)) c_(i k)(t) lambda_k Delta t.
$

若一个任务节点同时被多架 UAV 覆盖，则按并行采集处理，该节点产生的数据可进入对应多架 UAV 的队列。

*等效转发流量。* 基于第 3.4 节得到的链路速率 $r_(i j)(t)$，定义 UAV $i$ 在时隙 $t$ 的等效转发流入速率和流出速率分别为

$
r_i^"in"(t)
=
sum_(j in cal(U), j != i)
r_(j i)(t),
$

$
r_i^"out"(t)
=
sum_(j in cal(U), j != i)
r_(i j)(t)
+
r_(i s)(t).
$

对应的数据流入量和流出量为

$
F_i^"in"(t) = r_i^"in"(t) Delta t,
quad
F_i^"out"(t) = r_i^"out"(t) Delta t.
$

*队列更新。* 设 $Q_i(t)$ 为 UAV $i$ 在时隙 $t$ 的缓存队列长度，初始队列为

$
Q_i(0) = 0.
$

则队列状态更新为

$
Q_i(t + 1)
=
op("clip")(
  Q_i(t)
  +
  A_i(t)
  +
  (r_i^"in"(t) - r_i^"out"(t)) Delta t,
  0,
  Q_i^"max"
),
$

其中 $Q_i^"max"$ 为 UAV $i$ 的最大缓存容量。系统总队列长度定义为

$
Q_"sys"(t)
=
sum_(i in cal(U))
Q_i(t).
$

*连通性表征。* Sink 侧的总汇聚速率为

$
R_s(t)
=
sum_(i in cal(U))
r_(i s)(t).
$

单时隙内的等效数据泄放量为

$
D_s(t)
=
R_s(t) Delta t.
$

设 $epsilon_"con"$ 为最小数据泄放比例系数，则时隙 $t$ 的功能性连通约束可表示为

$
D_s(t)
>=
epsilon_"con" Q_"sys"(t).
$

相应地，定义连通性违约量为

$
V_"con"(t)
=
max(
  0,
  epsilon_"con" Q_"sys"(t) - D_s(t)
).
$

整个任务周期内的累计连通性违约量为

$
V_"con"^"sum"
=
sum_(t in cal(T))
V_"con"(t).
$

记系统总缓存容量为

$
Q_"max"
=
sum_(i in cal(U))
Q_i^"max".
$

则归一化连通性违约指标为

$
V_"con"^"norm"
=
V_"con"^"sum" / (T epsilon_"con" Q_"max").
$

数据队列模型由覆盖驱动的数据到达、链路速率驱动的等效转发和 Sink 数据泄放能力构成。其中，$Q_i(t)$ 用于刻画 UAV 缓存状态，$Q_"sys"(t)$ 用于刻画系统负载，$V_"con"^"norm"$ 用于后续综合目标函数与算法层级判优。

== 无人机能量消耗模型

UAV 的能量消耗由飞行能耗和通信发射能耗构成。对于任意 UAV $i in cal(U)$，其在时隙 $t$ 的飞行功率定义为

$
P_i^"fly"(t)
=
P_i^"hover"
+
c_(2, i)^"fly" v_i^2(t)
+
c_(3, i)^"fly" v_i^3(t),
$

其中，$P_i^"hover"$ 为悬停功率，$c_(2, i)^"fly"$ 和 $c_(3, i)^"fly"$ 分别为速度平方项和速度立方项飞行功率系数。对应的飞行能耗为

$
E_i^"fly"(t)
=
P_i^"fly"(t) Delta t.
$

通信能耗仅考虑发射功率消耗，表示为

$
E_i^"tx"(t)
=
P_i^"tx"(t) Delta t.
$

因此，UAV $i$ 在时隙 $t$ 的总功率为

$
P_i^"total"(t)
=
P_i^"fly"(t)
+
P_i^"tx"(t),
$

即

$
P_i^"total"(t)
=
P_i^"hover"
+
c_(2, i)^"fly" v_i^2(t)
+
c_(3, i)^"fly" v_i^3(t)
+
P_i^"tx"(t).
$

设 $E_i(t)$ 为 UAV $i$ 在时隙 $t$ 开始时的剩余能量，则能量状态更新为

$
E_i(t + 1)
=
op("clip")(
  E_i(t) - P_i^"total"(t) Delta t,
  0,
  E_i^"max"
),
$

初始能量满足

$
E_i(0) = E_i^"max".
$

系统在时隙 $t$ 内的总能耗为

$
E_"sys"(t)
=
sum_(i in cal(U))
P_i^"total"(t) Delta t.
$

整个任务周期内的累计系统能耗为

$
E_"sum"
=
sum_(t in cal(T))
E_"sys"(t).
$

记系统总初始能量容量为

$
E_"max"
=
sum_(i in cal(U))
E_i^"max".
$

归一化能耗指标定义为

$
E_"norm"
=
E_"sum" / (T E_"max").
$

能量部分由飞行功率、通信发射功率和剩余能量递推组成，归一化后的 $E_"norm"$ 用于后续目标函数中的能耗评价。

== 综合性能指标与优化目标函数

前文已经给出 UAV 运动、无线通信、地面节点覆盖、数据队列与连通性表征、能量消耗等模型。为了比较不同 UAV 控制方案，本节把 Sink 汇聚能力、系统队列负载、能量消耗、覆盖违约和连通性违约放入同一评价框架。Sink 汇聚能力越强，数据回传越充分；队列积压、能量消耗、覆盖不足和回传能力不足越低，方案代价越小。按这个思路，异构 UAV 动态路由规划被写成综合代价最小化问题。

本文沿用前文模型中得到的累计汇聚速率 $R_"sum"$、累计队列负载 $Q_"sum"$、累计系统能耗 $E_"sum"$、累计覆盖违约量 $V_"cov"^"sum"$ 和累计连通性违约量 $V_"con"^"sum"$，并将其归一化为如下评价指标：

$
R_"norm" = R_"sum" / (T R_"max"),
quad
Q_"norm" = Q_"sum" / (T Q_"max"),
quad
E_"norm" = E_"sum" / (T E_"max").
$

$
V_"cov"^"norm" = V_"cov"^"sum" / (T K),
quad
V_"con"^"norm" = V_"con"^"sum" / (T epsilon_"con" Q_"max").
$

其中，$R_"max"$ 为系统理论最大 Sink 汇聚速率，$Q_"max"$ 为系统总缓存容量，$E_"max"$ 为系统总初始能量容量。$R_"norm"$ 越大，UAV-Sink 链路的平均汇聚能力越强；$Q_"norm"$ 和 $E_"norm"$ 越小，系统队列积压和能量消耗越低；$V_"cov"^"norm"$ 和 $V_"con"^"norm"$ 越小，覆盖不足和回传不足越少。这里的 $V_"con"^"norm"$ 描述数据回传能力不足，不等同于严格图论意义上的拓扑全连通约束。

基于上述归一化指标，定义通信性能项为

$
J_"perf"
=
-lambda_0 R_"norm"
+
lambda_1 Q_"norm"
+
lambda_2 E_"norm",
$

$lambda_0$ 对应 Sink 汇聚能力，$lambda_1$ 和 $lambda_2$ 对应队列负载与能耗。由于优化方向是最小化，吞吐量越大目标值应越小，所以 $R_"norm"$ 前取负号；队列积压和能量消耗属于代价，仍以正项进入目标函数。

将覆盖违约和连通性违约纳入综合目标函数，得到

$
J_"total"
=
J_"perf"
+
lambda_3 V_"cov"^"norm"
+
lambda_4 V_"con"^"norm".
$

即

$
J_"total"
=
-lambda_0 R_"norm"
+
lambda_1 Q_"norm"
+
lambda_2 E_"norm"
+
lambda_3 V_"cov"^"norm"
+
lambda_4 V_"con"^"norm".
$

其中，$lambda_3$ 和 $lambda_4$ 分别为覆盖违约和连通性违约的惩罚权重。本文以最小化 $J_"total"$ 为优化目标。目标函数奖励 Sink 侧汇聚能力，同时惩罚队列积压、能量消耗、覆盖不足和回传能力不足，用一个标量目标表示覆盖、回传、吞吐、队列和能耗之间的折中。

本文实验中采用的默认权重为

$
lambda_0 = 0.40,
quad
lambda_1 = 0.20,
quad
lambda_2 = 0.15,
quad
lambda_3 = 0.15,
quad
lambda_4 = 0.10.
$

具体实验参数设置将在第 5 章中说明。

只看加权和目标函数时，算法可能为了换取局部通信性能而牺牲覆盖或回传状态。对灾后应急通信来说，这种取舍并不合适：地面节点先要被服务，数据也要能够回到 Sink。为此，综合目标之外还需要一套层级判优逻辑。

比较两个候选方案时，先比较归一化覆盖违约指标 $V_"cov"^"norm"$。若两个方案的覆盖违约差异超过阈值 $eta_"cov"$，覆盖违约较小者优先；若覆盖违约接近，再比较归一化连通性违约指标 $V_"con"^"norm"$。当连通性违约差异超过阈值 $eta_"con"$ 时，连通性违约较小者优先；若二者仍接近，再比较通信性能项 $J_"perf"$，最后比较综合目标值 $J_"total"$。

该判优逻辑可概括为

$
V_"cov"^"norm"
->
V_"con"^"norm"
->
J_"perf"
->
J_"total".
$

在本文实验设置中，覆盖违约比较阈值取

$
eta_"cov" = 0.01,
$

连通性违约比较阈值取

$
eta_"con" = 0.001.
$

按照这一顺序比较后，覆盖状态和回传能力较好的候选解会先被保留下来；只有两者差距不大时，才继续比较吞吐量、队列负载和能耗。这个顺序对应应急通信中的基本取舍：先保证可覆盖、可回传，再讨论通信性能的细化。

== 动态路由规划问题描述

在前述系统模型基础上，本文将异构无人机集群通信网络动态路由规划写成面向控制序列的优化问题。这里的动态路由规划不是协议层面的显式下一跳选择，也不是数据包级路径优化；它是在 UAV 运动、链路速率和数据队列不断变化的条件下，联合优化 UAV 运动控制与发射功率，使任务周期内的数据持续汇聚到 Sink。

=== 优化变量与目标函数

本文以控制段为单位描述 UAV 控制序列。对于任意 UAV $i in cal(U)$ 和控制段 $g in cal(G)$，定义控制向量为

$
bold(u)_i(g)
=
[
  hat(v)_i(g),
  hat(theta)_i(g),
  P_i^"tx"(g)
]^top.
$

其中，$hat(v)_i(g)$ 为期望飞行速度，$hat(theta)_i(g)$ 为期望航向角，$P_i^"tx"(g)$ 为发射功率。由所有 UAV 在全部控制段上的控制向量组成整体优化变量：

$
bold(U)
=
brace.l
  bold(u)_i(g)
  mid
  i in cal(U),
  g in cal(G)
brace.r.
$

给定控制序列 $bold(U)$ 后，第 3.3 至第 3.7 节的模型会依次推出 UAV 位置、实际速度、航向、覆盖状态、链路速率、队列状态和剩余能量。再由这些状态量计算 $R_"norm"$、$Q_"norm"$、$E_"norm"$、$V_"cov"^"norm"$ 和 $V_"con"^"norm"$，即可得到 $J_"total"(bold(U))$。优化目标就是在可行控制序列中寻找综合代价最小的一组：

$
min_(bold(U))
J_"total"(bold(U)).
$

该目标函数同时纳入 Sink 汇聚速率、队列负载、能量消耗、覆盖违约和连通性违约。由于目标是最小化，吞吐量以负权重进入目标函数；队列、能耗、覆盖违约和连通性违约作为代价项加入。

=== 约束条件汇总

动态路由规划的约束分成两层。第一层是控制变量本身的取值范围；第二层来自仿真递推，即运动、通信、覆盖、队列和能量状态必须满足前文模型。

（C1）控制变量边界约束。对于任意 $i in cal(U)$、$g in cal(G)$，控制变量需满足

$
0 <= hat(v)_i(g) <= v_i^"max",
quad
0 <= hat(theta)_i(g) < 2 pi,
quad
0 <= P_i^"tx"(g) <= P_i^"max".
$

这里 $v_i^"max"$ 给出 UAV $i$ 的速度上界，$P_i^"max"$ 给出发射功率上界；期望航向角 $hat(theta)_i(g)$ 统一映射到 $[0, 2 pi)$ 内。控制变量的可行集合写为

$
cal(F)
=
brace.l
  bold(U) mid
  & 0 <= hat(v)_i(g) <= v_i^"max",
  \
  & 0 <= hat(theta)_i(g) < 2 pi,
  \
  & 0 <= P_i^"tx"(g) <= P_i^"max",
  \
  & forall i in cal(U), g in cal(G)
brace.r.
$

（C2）运动与安全约束。控制序列进入仿真执行过程后，UAV 的实际速度、航向和位置由第 3.3 节的运动模型递推得到。实际运动过程需满足最大速度、最大加速度、最大转角、最大角速度和最小转弯半径等约束；当候选位置导致 UAV 间距离小于 $d_"safe"$ 时，系统通过位置修正机制保持安全距离。

（C3）通信、覆盖与队列约束。对于任意可行控制序列，链路速率由第 3.4 节的无线通信模型计算，地面节点覆盖状态由第 3.5 节的覆盖模型判定，队列状态由第 3.6 节的数据到达、UAV 间转发和 Sink 泄放过程共同递推。UAV 缓存队列需保持在其容量范围内，即 $0 <= Q_i(t) <= Q_i^"max"$。

（C4）能量约束。UAV 剩余能量由第 3.7 节的能量模型递推得到，飞行功率和通信发射功率共同决定能量消耗。任意时隙内剩余能量需保持在 $[0, E_i^"max"]$ 范围内。覆盖不足和回传能力不足不作为硬约束直接强制满足，而是通过 $V_"cov"^"norm"$ 和 $V_"con"^"norm"$ 进入目标函数及后续层级判优过程。

为简化问题表示，本文将由第 3.3 至第 3.7 节共同构成的状态递推过程记为

$
(
  bold(P),
  bold(R),
  bold(Z),
  bold(Q),
  bold(E)
)
=
Phi(bold(U)).
$

这里的 $bold(P)$ 记录 UAV 位置随时间的变化，$bold(R)$ 记录链路速率，$bold(Z)$、$bold(Q)$ 与 $bold(E)$ 分别对应覆盖状态、队列状态和剩余能量序列。映射 $Phi(dot)$ 不是额外模型，而是第 3.3 至第 3.7 节中运动、通信、覆盖、队列和能量递推关系的合写。

整理上述目标与约束后，本文的动态路由规划问题可表示为

$
cal(P):
quad
min_(bold(U))
J_"total"(bold(U))
$

$
"s.t."
quad
& 0 <= hat(v)_i(g) <= v_i^"max",
\
& 0 <= hat(theta)_i(g) < 2 pi,
\
& 0 <= P_i^"tx"(g) <= P_i^"max",
\
& forall i in cal(U), g in cal(G),
$

$
& 0 <= Q_i(t) <= Q_i^"max",
\
& 0 <= E_i(t) <= E_i^"max",
\
& forall i in cal(U), t in cal(T),
$

$
(
  bold(P),
  bold(R),
  bold(Z),
  bold(Q),
  bold(E)
)
=
Phi(bold(U)).
$

其中，$cal(P)$ 表示本文构建的异构 UAV 集群动态路由规划优化问题。第一组约束对应控制变量边界约束（C1），第二组约束对应队列容量和剩余能量范围约束（C3）与（C4），第三组约束要求系统状态满足第 3.3 至第 3.7 节定义的运动、通信、覆盖、队列和能量动态递推关系。安全距离约束包含在运动模型及其位置修正机制中，覆盖不足和回传能力不足则通过目标函数中的违约项及层级判优过程处理。

=== 问题性质分析

从变量结构看，本文构建的动态路由规划问题属于高维连续优化问题。每架 UAV 在每个控制段内需要优化期望速度、期望航向角和发射功率三个连续控制量，优化维度为

$
D = 3 N G.
$

若直接在每个时隙独立优化控制量，则原始维度为

$
D_"raw" = 3 N T.
$

通常有 $G < T$，控制段建模可以降低一部分维度，但剩余搜索空间仍然很大。

非线性主要来自模型内部的状态递推。UAV 位置更新包含三角函数项，通信距离计算包含欧氏范数，信道增益与距离平方相关，链路速率由 Shannon 对数函数给出，飞行能耗还包含速度的二次项和三次项。优化变量与目标函数之间不是简单的线性关系。

该问题还包含非凸和非光滑因素。覆盖指示量由距离阈值判定得到：

$
c_(i k)(t)
=
bb(I)(
  d_(i k)^"g"(t) <= R_i^"cov"
).
$

这一判定会使覆盖状态随 UAV 位置变化发生离散跳变。队列更新和能量更新中存在截断运算，覆盖违约与连通性违约中也有 $max(dot)$ 运算，目标函数因此会出现不可光滑变化。

时序耦合是另一个难点。某一控制段中的速度、航向和发射功率会影响当前时隙的 UAV 位置、链路速率、覆盖关系和能耗，也会通过位置演化、队列积压和剩余能量变化传递到后续时隙。该问题与一次性静态优化不同，更接近动态时域优化。

控制变量与多个评价指标之间也存在相互牵制。速度和航向共同决定 UAV 轨迹，并改变覆盖状态、通信距离和飞行能耗；发射功率影响链路速率、Sink 汇聚能力和通信能耗；覆盖状态影响地面数据到达；链路速率和队列状态又会改变连通性违约和系统稳定性。若只优化单一指标，容易把压力转移到其他指标上。

基于上述性质，本文问题不写成显式混合整数规划模型，而写成带有阈值覆盖判定和多类违约评价项的动态连续优化问题。传统精确优化方法很难直接处理这类状态递推和非光滑评价，后续章节转向覆盖状态感知 L-SHADE 进行近似求解。

== 章节小结

本章把异构无人机集群通信网络的动态路由规划问题写成可计算的优化模型。建模以固定高度二维应急通信场景为基础，随后拆解模型的组成，包括 UAV 运动、无线传输、节点覆盖、队列变化、回传连通和能量消耗。这样处理后，覆盖服务、数据回传和资源消耗不再是分散的指标，而是在同一条时间序列上共同变化的状态。速度、航向角和发射功率也被放入同一组决策变量中，它们会同时影响覆盖关系、链路质量、队列压力和能耗水平。

综合目标函数将吞吐量、队列负载、能量消耗、覆盖违约和连通性违约均纳入评价体系。与此同时，分层判优规则保留了应急通信中的实际取舍：先看覆盖和回传是否成立，再比较吞吐、队列和能耗等综合性能。由此得到的问题并不容易直接求解。控制变量维度高，目标和约束中又包含非线性、非光滑和跨时隙递推关系，传统精确优化方法很难完整处理这些因素。因此，第 4 章转向覆盖状态感知 L-SHADE，不只是算法选择上的替换，也是由模型结构自然引出的求解需求。

= 覆盖状态感知 L-SHADE 路由优化算法

第 3 章已经把路由规划写成控制序列优化问题，本章转向求解算法。原始 L-SHADE 可以处理连续控制变量，但它不知道当前种群是否已经形成有效覆盖结构，也无法区分覆盖构造、覆盖保持和性能精修这些阶段。因此，本章先给出 L-SHADE 在本文问题中的编码、解码、评估和选择方式，再引入覆盖优先初始化与覆盖状态感知参数控制，最后整理覆盖状态感知 L-SHADE 的流程和复杂度。

== L-SHADE 求解框架

第 2 章已介绍 L-SHADE 的一般机制。本节只说明它在本文问题中的落地方式：控制序列怎样编码为个体，个体怎样进入动态仿真，仿真后的评价向量又怎样参与选择。

一个个体对应完整任务周期内所有 UAV 的分段控制序列。UAV $i$ 在控制段 $g$ 的控制向量写作

$
bold(u)_i(g)
=
[
  hat(v)_i(g),
  hat(theta)_i(g),
  P_i^"tx"(g)
]^top.
$

因此，候选解可表示为由所有 UAV、所有控制段控制量拼接而成的连续向量：

$
bold(x) in RR^D,
quad
D = 3 N G.
$

$N$ 表示 UAV 数量，$G$ 表示控制段数量。这样编码后，轨迹控制和发射功率控制都进入同一个连续搜索空间。

对于任意候选解 $bold(x)$，算法先将其解码为完整时域动作序列，并输入第 3 章建立的动态仿真模型。仿真结束后得到个体评价向量：

$
bold(C)(bold(x))
=
(
  V_"cov"^"norm",
  V_"con"^"norm",
  J_"perf",
  J_"total"
).
$

普通 L-SHADE 通常直接比较单一目标值。本文改用覆盖与回传能力优先的层级判优规则：先比较 $V_"cov"^"norm"$，再比较 $V_"con"^"norm"$，在二者相近时比较 $J_"perf"$ 和 $J_"total"$。该规则让搜索过程先压低覆盖违约和回传能力违约，再优化由吞吐、队列和能耗组成的综合性能。

变异阶段使用 current-to-pbest/1 策略，变异向量为

$
bold(v)_i
=
bold(x)_i
+
F_i (bold(x)_"pbest" - bold(x)_i)
+
F_i (bold(x)_(r_1) - bold(x)_(r_2)).
$

其中，$bold(x)_"pbest"$ 从当前种群前 $p$ 比例优秀个体中随机选取，$F_i$ 为缩放因子，$bold(x)_(r_2)$ 可来自当前种群或外部档案。随后，变异向量经二项交叉形成试验个体，并按第 3 章定义的速度、航向角和发射功率范围进行边界修复。

在参数生成上，L-SHADE 仍从成功历史记忆中采样 $F_i$ 和 $C R_i$；在种群规模上，它按线性缩减规则从较大的初始种群逐步过渡到较小种群。本文提出的覆盖状态感知参数控制机制并不替换这些步骤。它只在参数采样之后读取种群覆盖状态，再对 $p$、$F$ 和 $C R$ 做状态相关约束。换句话说，覆盖状态感知 L-SHADE 的连续搜索主体仍是 L-SHADE，新增部分负责告诉算法当前应更重视覆盖构造、覆盖保持还是性能细化。

==  L-SHADE 不足

原始 L-SHADE 具有较强的连续优化能力，但本文研究的异构 UAV 动态覆盖路由问题并不是一般黑箱连续优化问题。候选解由多架 UAV 在多个控制段内的速度、航向角和发射功率组成，目标值由 UAV 轨迹、地面覆盖、链路速率、队列演化和能量消耗共同决定。覆盖状态在这里尤其敏感：它既是综合目标函数中的惩罚项，也是后续数据到达、队列更新和 Sink 回传能力评价的基础。若算法不能在搜索过程中形成并维持覆盖结构，后续吞吐量、队列负载和能耗优化都会受到限制。

随机初始化是第一个问题。本文中一个个体对应 $D = 3 N G$ 维 UAV 分段控制向量，随机生成的速度、航向角和发射功率序列不包含任务节点空间分布信息，初始 UAV 轨迹可能偏离任务节点密集区域。当初始种群整体覆盖水平较低时，算法需要消耗较多函数评估次数修正轨迹方向，搜索前期覆盖违约也会偏高。这个问题本质上是搜索入口与有效覆盖区域之间存在结构性偏差。

差分变异也有类似问题。L-SHADE 的扰动本质上是通用向量扰动，搜索方向主要由种群中个体差分和 pbest 引导项决定。本文问题中，控制变量与性能指标之间存在明确的物理耦合关系：速度和航向角影响 UAV 位置，位置决定覆盖关系和链路距离，发射功率同时影响传输速率和通信能耗。原始差分扰动并不显式感知任务节点位置、覆盖半径和 Sink 回传方向，难以稳定产生符合覆盖路由结构的搜索行为。

覆盖判定还带有明显的阈值非光滑性。任务节点是否被覆盖由 UAV 与任务节点之间的距离是否小于覆盖半径决定，即

$
c_(i k)(t)
=
bb(I)(
  d_(i k)^"g"(t) <= R_i^"cov"
).
$

在这个阈值附近，连续控制变量的小幅变化可能让任务节点突然从未覆盖变为已覆盖，也可能因为没有跨过覆盖边界而几乎不改变评价值。成功历史参数记录到的只是试验个体是否变好，很难分辨这种变化来自真实搜索方向，还是来自覆盖边界上的跳变。因此，$F$ 和 $C R$ 的历史经验在本文问题中会带有一定噪声。

参数控制同样不能忽略覆盖状态。本文问题中，搜索早期需要较强探索以构造覆盖结构；覆盖初步形成后，需要降低破坏性扰动以维持覆盖；覆盖稳定后，才适合继续优化吞吐量、队列负载和能耗。若覆盖发生退化，算法还需要重新加强覆盖恢复能力。原始 L-SHADE 主要依赖历史成功参数进行自适应，缺少对上述覆盖阶段的显式判断，容易在覆盖尚未稳定时过早转向性能优化，或在覆盖退化后缺少恢复机制。

基于上述分析，本文保留 L-SHADE 的连续搜索框架，但在两个位置加入问题结构信息：覆盖优先初始化机制用于改善初始种群的覆盖质量，覆盖状态感知参数控制机制用于根据种群覆盖状态动态调节 $p$、$F$ 和 $C R$。前者处理搜索入口问题，后者处理搜索过程中的覆盖状态适配问题。

== 覆盖优先初始化机制

随机初始化容易把 UAV 带向与任务节点无关的区域，搜索一开始就可能处在低覆盖状态。为降低这种冷启动代价，覆盖状态感知 L-SHADE 在初始种群中加入覆盖优先初始化机制。该机制利用地面任务节点分布生成一部分覆盖导向个体，但它只改变初始入口，不干预后续变异、交叉、选择、外部档案和成功历史记忆更新。

生成覆盖导向初始个体时，先从任务节点中抽取若干覆盖引导点。记任务节点集合为 $cal(K) = brace.l 1, 2, dots, K brace.r$，节点 $k$ 的位置为 $bold(q)_k$，引导点数量取

$
N_c = min(N, K)
$

也就是说，引导点数量不超过 UAV 数量，也不超过任务节点数量。选择目标点时，先用任务节点质心找到一个中心附近的起点：

$
overline(bold(q))
=
1 / K
sum_(k in cal(K))
bold(q)_k.
$

选取距离质心最近的任务节点作为初始目标点：

$
k_1
=
arg min_(k in cal(K))
norm(bold(q)_k - overline(bold(q)))_2.
$

之后逐步扩展目标集合。设已选目标为 $cal(C)$，每次都在未选节点中寻找离 $cal(C)$ 最远的一个：

$
k^*
=
arg max_(k in cal(K) without cal(C))
min_(m in cal(C))
norm(bold(q)_k - bold(q)_m)_2.
$

重复上述过程，直至满足

$
|cal(C)| = N_c.
$

这样得到的目标集合 $cal(C)$ 可在任务区域内形成相对分散的覆盖引导点。

目标点选好后，再把它们分配给 UAV。分配时按 UAV 顺序进行贪心匹配。设 $cal(C)_i$ 为分配到 UAV $i$ 时仍未使用的目标集合；若集合非空，则取离 UAV 初始位置最近的目标：

$
k(i)
=
arg min_(k in cal(C)_i)
norm(bold(p)_i(0) - bold(q)_k)_2.
$

若所有目标均已被分配，则允许目标复用，此时有

$
k(i)
=
arg min_(k in cal(C))
norm(bold(p)_i(0) - bold(q)_k)_2.
$

这样可以让可用目标先被不同 UAV 占用；若 UAV 数量多于任务节点数量，多出的 UAV 再从已有目标中选择最近者。

为避免覆盖导向初始个体在同一目标附近完全重合，本文在分配目标周围引入随机扰动。UAV $i$ 的扰动目标位置定义为

$
tilde(bold(q))_i
=
bold(q)_(k(i))
+
bold(xi)_i,
$

其中

$
bold(xi)_i
∼
cal(N)(
  bold(0),
  sigma_i^2 bold(I)_2
).
$

扰动尺度 $sigma_i$ 与 UAV 覆盖半径和任务节点空间分布有关。当任务节点数量为 1 时，取

$
sigma_i
=
0.15 R_i^"cov".
$

否则，取

$
sigma_i
=
min(
  max(
    0.05 R_i^"cov",
    0.08 norm(
      op("std")(
        brace.l bold(q)_k brace.r_(k in cal(K))
      )
    )_2
  ),
  0.25 R_i^"cov"
).
$

$op("std")(brace.l bold(q)_k brace.r_(k in cal(K)))$ 由所有任务节点坐标计算，数值越大，说明节点在平面上的分布越分散。

得到扰动目标点以后，覆盖优先初始化机制开始为每架 UAV 生成分段控制序列。UAV $i$ 在控制段 $g in cal(G)$ 的控制向量仍写作

$
bold(u)_i(g)
=
[
  hat(v)_i(g),
  hat(theta)_i(g),
  P_i^"tx"(g)
]^top.
$

设控制段总数为 $G$，接近阶段的基准长度为

$
G_"tr"
=
ceil(0.25 G).
$

令 $overline(bold(p))_i(g) = [overline(x)_i(g), overline(y)_i(g)]^top$ 表示生成第 $g$ 个控制段时的 UAV 估计位置。若满足

$
g < G_"tr"
$

或

$
norm(overline(bold(p))_i(g) - tilde(bold(q))_i)_2
>
0.6 R_i^"cov",
$

则 UAV $i$ 在控制段 $g$ 采用接近模式。此时，期望航向角指向扰动目标：

$
hat(theta)_i(g)
=
op("atan2")(
  tilde(y)_i - overline(y)_i(g),
  tilde(x)_i - overline(x)_i(g)
).
$

速度和发射功率分别由比例系数生成：

$
hat(v)_i(g)
=
alpha_(v, i)^"tr"(g) v_i^"max",
quad
alpha_(v, i)^"tr"(g) ~ cal(U)(0.65, 0.90),
$

$
P_i^"tx"(g)
=
alpha_(p, i)^"tr"(g) P_i^"max",
quad
alpha_(p, i)^"tr"(g) ~ cal(U)(0.65, 0.90).
$

不满足上述条件时，说明 UAV 已接近目标区域或已过接近阶段，此时转入保持模式。期望航向仍参考目标方向，但加入小幅角度扰动：

$
hat(theta)_i(g)
=
op("atan2")(
  tilde(y)_i - overline(y)_i(g),
  tilde(x)_i - overline(x)_i(g)
)
+
zeta_i(g),
$

其中

$
zeta_i(g) ~ cal(U)(-0.35, 0.35).
$

保持模式下的速度和发射功率为

$
hat(v)_i(g)
=
alpha_(v, i)^"h"(g) v_i^"max",
quad
alpha_(v, i)^"h"(g) ~ cal(U)(0.05, 0.20),
$

$
P_i^"tx"(g)
=
alpha_(p, i)^"h"(g) P_i^"max",
quad
alpha_(p, i)^"h"(g) ~ cal(U)(0.45, 0.70).
$

生成后的控制变量需满足第三章定义的边界条件：

$
0 <= hat(v)_i(g) <= v_i^"max",
quad
0 <= hat(theta)_i(g) < 2 pi,
quad
0 <= P_i^"tx"(g) <= P_i^"max".
$

进入仿真评估后，这些期望控制量还要经过加速度、最大转角、最大角速度、最小转弯半径和安全距离修正。

覆盖优先初始化与随机初始化共同构成初始种群。设初始种群规模为 $N P_0$，覆盖优先初始化比例为 $rho_"init"$，则覆盖导向初始个体数量和随机初始化个体数量分别为

$
N P_"cov"
=
op("round")(
  rho_"init" N P_0
),
$

$
N P_"rand"
=
N P_0 - N P_"cov".
$

本文实验中采用混合初始化设置：

$
N P_0 = 100,
quad
rho_"init" = 0.5.
$

在该设置下，初始种群中约一半个体由覆盖优先初始化机制生成，其余个体由随机初始化生成。初始化完成后，两类个体不再区别处理，均作为 L-SHADE 种群中的实数向量参与后续搜索。这样，初始种群在保持随机多样性的同时获得覆盖导向结构，为后续覆盖状态感知参数控制提供更稳定的搜索基础。

== 覆盖状态感知参数控制机制

覆盖优先初始化改善了初始种群的覆盖质量，但在后续差分进化过程中，种群仍可能出现覆盖退化或过早转向性能优化。为此，本文在覆盖优先初始化 L-SHADE 的基础上引入覆盖状态感知参数控制机制。该机制根据种群覆盖状态动态约束 $p$、$F$ 和 $"CR"$，使算法在覆盖构造、覆盖稳定、性能精修和覆盖恢复阶段采用不同搜索尺度。

=== 覆盖状态指标构造

设第 $ell$ 代种群为

$
cal(P)^(ell)
=
brace.l
  bold(x)_1^(ell),
  bold(x)_2^(ell),
  dots,
  bold(x)_(N P_ell)^(ell)
brace.r,
$

其中 $N P_ell$ 为第 $ell$ 代种群规模。每个个体经完整动态仿真后得到评价向量

$
bold(C)(bold(x)_i^(ell))
=
(
  V_"cov"^"norm",
  V_"con"^"norm",
  J_"perf",
  J_"total"
).
$

本文按字典序对 $bold(C)(bold(x)_i^(ell))$ 进行升序排序，即先比较覆盖违约，再比较连通性违约，随后比较通信性能项和综合目标值。设排序后的种群为

$
op("rank")(
  cal(P)^(ell)
).
$

取前 $rho_e$ 比例个体构成精英集合：

$
N_e^(ell)
=
ceil(rho_e N P_ell),
quad
rho_e = 0.20.
$

$
cal(E)^(ell)
=
brace.l
  bold(x) in op("rank")(cal(P)^(ell))
  mid
  op("rank")(bold(x)) <= N_e^(ell)
brace.r.
$

基于精英集合，定义精英覆盖违约均值

$
g_ell
=
1 / |cal(E)^(ell)|
sum_(bold(x) in cal(E)^(ell))
V_"cov"^"norm"(bold(x)).
$

设 coverage-safe 阈值为

$
tau_"safe" = 0.10.
$

第 $ell$ 代种群中的 coverage-safe 比例定义为

$
r_ell
=
1 / (N P_ell)
sum_(i = 1)^(N P_ell)
bb(I)(
  V_"cov"^"norm"(bold(x)_i^(ell))
  <=
  tau_"safe"
).
$

设状态判断窗口长度为

$
L_s = 5,
$

定义精英覆盖违约变化量为

$
Delta g_ell
=
g_(ell - L_s) - g_ell.
$

覆盖状态感知 L-SHADE 采用三类覆盖状态统计量

$
(
  g_ell,
  r_ell,
  Delta g_ell
)
$

$g_ell$ 反映精英个体的平均覆盖违约，$r_ell$ 反映 coverage-safe 个体在种群中的扩散程度，$Delta g_ell$ 则观察最近几代覆盖违约是否还在改善。

=== 覆盖状态机

定义覆盖状态空间为

$
cal(S)
=
brace.l
  S_1, S_2, S_3, S_4
brace.r,
$

四个状态的含义见表 4-1：$S_1$ 对应覆盖构造，$S_2$ 对应覆盖稳定，$S_3$ 对应性能精修，$S_4$ 对应覆盖恢复。

#align(center)[表 4-1 覆盖状态定义]

#three-line-table(
  columns: (auto, auto, 1fr, 1fr),
  table.header([状态], [名称], [状态含义], [搜索目标]),
  [$S_1$], [Coverage Construction], [覆盖尚未建立], [快速形成覆盖结构],
  [$S_2$], [Coverage Stabilization], [覆盖初步形成但尚不稳定], [稳定并扩散覆盖结构],
  [$S_3$], [Performance Refinement], [覆盖已相对稳定], [优化吞吐、队列和能耗],
  [$S_4$], [Coverage Recovery], [覆盖发生退化], [恢复覆盖结构],
)

状态机不只依赖单个最优个体，而是同时读取 $g_ell$、$r_ell$、$Delta g_ell$ 和稳定计数器 $c_"stab"$。转移判断中用到以下阈值：

$
tau_H = 0.15,
quad
tau_L = 0.10,
$

$
r_L = 0.20,
quad
r_H = 0.50,
$

$
Delta_"stable" = 0.002,
quad
H_"req" = 3,
$

$
tau_"recover" = 0.11,
quad
r_"recover" = 0.40.
$

稳定条件定义为

$
cal(A)_ell
=
[g_ell <= tau_L]
and
[r_ell >= r_H]
and
[Delta g_ell <= Delta_"stable"].
$

稳定计数器按如下规则更新：若 $cal(A)_ell$ 成立，则 $c_"stab" <- c_"stab" + 1$；否则 $c_"stab" <- 0$。

覆盖状态转移函数定义为

$
S_(ell + 1)
=
cal(F)(
  S_ell,
  g_ell,
  r_ell,
  Delta g_ell,
  c_"stab"
).
$

具体转移规则如下：

#align(center)[表 4-2 覆盖状态转移规则]

#three-line-table(
  columns: (auto, 1fr),
  table.header([转移结果], [触发条件]),
  [$S_(ell + 1) = S_2$], [$S_ell = S_1$, $g_ell <= tau_H$，且 $r_ell >= r_L$],
  [$S_(ell + 1) = S_3$], [$S_ell = S_2$，且 $c_"stab" >= H_"req"$],
  [$S_(ell + 1) = S_4$], [$S_ell = S_3$，且 $g_ell > tau_"recover"$ 或 $r_ell < r_"recover"$],
  [$S_(ell + 1) = S_2$], [$S_ell = S_4$，$g_ell <= tau_H$，且 $r_ell >= r_L$],
  [$S_(ell + 1) = S_1$], [$S_ell = S_4$，且 $g_ell > tau_H$ 或 $r_ell < r_L$],
  [$S_(ell + 1) = S_ell$], [其他情况],
)

$S_4$ 只在性能精修后发生覆盖退化时出现。若恢复过程重新达到基本覆盖条件，状态转回 $S_2$；若仍不能恢复，则回到 $S_1$ 重新构造覆盖。

=== 状态驱动的 p/F/CR 控制

覆盖状态感知 L-SHADE 保留 L-SHADE 的成功历史记忆机制。对于个体 $bold(x)_i^(ell)$，缩放因子和交叉概率先由历史记忆采样得到：

$
F_i
∼
op("Cauchy")(
  M_F[r],
  0.1
),
$

$
"CR"_i
∼
cal(N)(
  M_"CR"[r],
  0.1
),
$

其中 $r$ 为随机选取的历史记忆索引。随后，根据当前覆盖状态 $S_ell$ 对参数进行状态相关裁剪：

$
F_i
<-
op("clip")(
  F_i,
  F_"min"(S_ell),
  F_"max"(S_ell)
).
$

$
"CR"_i
<-
op("clip")(
  "CR"_i,
  "CR"_"min"(S_ell),
  "CR"_"max"(S_ell)
).
$

同时，pbest 选择比例由当前状态确定：

$
p_ell
=
p(S_ell).
$

状态驱动参数设置如表 4-3 所示。

#align(center)[表 4-3 状态驱动参数设置]

#three-line-table(
  columns: (1fr, auto, auto, auto, 1fr),
  table.header([覆盖状态], [$p_ell$], [$F$ 范围], [$"CR"$ 范围], [参数控制意图]),
  [$S_1$ Coverage Construction], [0.08], [$[0.50, 0.80]$], [$[0.15, 0.40]$], [加强覆盖构造],
  [$S_2$ Coverage Stabilization], [0.10], [$[0.35, 0.60]$], [$[0.10, 0.30]$], [稳定覆盖结构],
  [$S_3$ Performance Refinement], [0.15], [$[0.20, 0.50]$], [$[0.10, 0.35]$], [精修通信性能],
  [$S_4$ Coverage Recovery], [0.08], [$[0.35, 0.60]$], [$[0.10, 0.25]$], [恢复覆盖结构],
)

覆盖状态感知参数控制机制并不替代 L-SHADE 的成功历史自适应，而是在其采样结果外施加覆盖状态约束。$p_ell$ 控制 pbest 候选范围，$F_i$ 控制差分变异步长，$"CR"_i$ 控制交叉强度。覆盖构造和覆盖恢复状态采用较小 $p_ell$，以强化高覆盖个体的引导；覆盖稳定和性能精修状态逐步降低搜索扰动，使算法在保持覆盖结构的基础上优化吞吐量、队列负载和能耗。

覆盖状态感知参数控制机制将 $V_"cov"^"norm"$ 的种群统计量引入 L-SHADE 参数控制过程。该机制不改变第 3 章定义的目标函数，也不引入新的覆盖硬约束，而是在搜索过程中动态调整 $p$、$F$ 和 $"CR"$，使算法能区分覆盖构造、覆盖稳定、性能精修和覆盖恢复阶段。
== 覆盖状态感知 L-SHADE 算法流程

本文构建的覆盖状态感知 L-SHADE 算法用于求解异构 UAV 集群通信网络动态路由规划问题。算法以 L-SHADE 为基础框架，以 UAV 分段控制序列作为个体编码，通过完整动态仿真获得个体评价向量，并按覆盖优先、连通次优先、性能再优化的层级判优规则更新种群。流程上，算法先利用覆盖优先初始化机制生成覆盖导向初始个体，再根据种群覆盖状态动态调整 $p$、$F$ 和 $"CR"$，随后执行 L-SHADE 主循环中的变异、交叉、选择、档案更新、成功历史记忆更新和线性种群缩减。

覆盖状态感知 L-SHADE 的完整流程如算法 4-1 所示。

#let AlgLine(block) = (block,)

#algorithm(
  title: [覆盖状态感知 L-SHADE 算法流程],
  {
    AlgLine[输入：$op("MaxNFE")$, $N P_0$, $N P_"min"$, $rho_"init"$, $H$]
    AlgLine[输出：最优控制序列 $bold(x)^*$ 及其评价指标]

    Assign[$op("NFE")$][$0$]
    Assign[$ell$][$0$]
    Assign[$cal(A)$][$emptyset$]

    AlgLine[初始化 $M_F$、$M_"CR"$，设置 $S_0 = S_1$，$c_"stab" = 0$]
    AlgLine[基于覆盖优先初始化与随机初始化生成初始种群 $cal(P)^(0)$]
    AlgLine[评估 $cal(P)^(0)$，并确定初始最优个体 $bold(x)^*$]

    While(
      [$op("NFE") < op("MaxNFE")$],
      {
        AlgLine[根据线性缩减规则更新 $N P_ell$]
        AlgLine[按层级判优排序并截断种群]
        AlgLine[计算 $g_ell$、$r_ell$、$Delta g_ell$，并更新状态 $S_ell$]

        Assign[$i$][$1$]
        While(
          [$i <= N P_ell$],
          {
            AlgLine[从 $M_F$、$M_"CR"$ 采样 $F_i$、$"CR"_i$]
            AlgLine[根据 $S_ell$ 裁剪 $F_i$、$"CR"_i$，并确定 $p_ell$]
            AlgLine[生成试验个体 $bold(y)_i$]
            AlgLine[修复边界并评估 $bold(y)_i$]

            IfElseChain(
              [$bold(y)_i$ 优于 $bold(x)_i^(ell)$],
              {
                Assign[$bold(x)_i^(ell + 1)$][$bold(y)_i$]
                AlgLine[将被替换个体加入外部档案 $cal(A)$]
                AlgLine[记录成功参数 $F_i$、$"CR"_i$]
              },
              {
                Assign[$bold(x)_i^(ell + 1)$][$bold(x)_i^(ell)$]
              },
            )

            AlgLine[更新全局最优个体 $bold(x)^*$]
            Assign[$i$][$i + 1$]
          },
        )

        AlgLine[更新 $M_F$、$M_"CR"$ 并调整外部档案规模]
        Assign[$ell$][$ell + 1$]
      },
    )

    Return[$bold(x)^*$]
  },
) <alg:coverage-state-aware-lshade>

上述流程中，覆盖优先初始化只作用于初始种群构造阶段，覆盖状态感知参数控制机制只作用于参数控制阶段，L-SHADE 主循环仍负责连续控制空间中的差分变异、交叉、选择和历史记忆更新。覆盖状态感知 L-SHADE 没有改变基础 L-SHADE 的主体演化结构，而是在初始化入口和参数控制层引入覆盖状态信息，使搜索过程能在覆盖构造、覆盖稳定、性能精修和覆盖恢复之间切换。
== 算法复杂度分析

覆盖状态感知 L-SHADE 的计算复杂度主要由决策空间维度、个体动态仿真评估和附加算子开销构成。其中，完整任务周期仿真是算法的主要计算瓶颈。

*1. 决策空间维度。*

覆盖状态感知 L-SHADE 的个体为 UAV 分段控制序列。设 UAV 数量为 $N$，控制段数量为

$
G = ceil(T / L_c),
$

每架 UAV 在每个控制段内包含期望速度、期望航向角和发射功率 3 个变量，单个候选解维度为

$
D = 3 N G.
$

由此可知，算法需要在随 $N$ 和 $G$ 线性增长的高维连续控制空间中搜索。

*2. 个体评估复杂度。*

每个候选解均需展开为完整时域动作序列，并在仿真环境中执行 $T$ 个时隙。单个时隙内，UAV-UAV 通信速率计算与安全距离检查主要涉及 $N^2$ 级计算，UAV-地面任务节点覆盖判定与数据到达计算主要涉及 $N K$ 级计算。单次个体评估的主复杂度为

$
O(T (N^2 + N K)).
$

若最大函数评价次数为 $op("MaxNFE")$，则由动态仿真评估产生的主导复杂度为

$
O(op("MaxNFE") dot T (N^2 + N K)).
$

*3. 附加算子开销。*

每代演化还包含排序、pbest 选择、变异交叉、边界修复、外部档案维护、历史记忆更新和种群缩减。设第 $ell$ 代种群规模为 $N P_ell$，这些步骤主要随 $N P_ell$ 与维度 $D$ 增长。它们需要计算，但通常比不上一次完整时域仿真的开销。

覆盖优先初始化机制只在初始化阶段执行一次，其开销来自覆盖目标选择、UAV-目标匹配和覆盖导向控制序列生成。覆盖状态感知参数控制机制在每代执行覆盖状态统计、有限状态机转移判断以及 $F$/$"CR"$ 参数裁剪，其中精英覆盖均值、coverage-safe 比例和状态转移判断均属于轻量级种群统计操作，不引入额外的时域仿真过程。

覆盖状态感知 L-SHADE 的总体计算成本仍由候选解的完整动态仿真评估主导。覆盖优先初始化和覆盖状态感知参数控制只带来一次性初始化开销或低阶种群级统计开销，不改变算法的渐进主复杂度阶。因此，覆盖状态感知 L-SHADE 与基础 L-SHADE 在主阶上保持一致：

$
O(op("MaxNFE") dot T (N^2 + N K)).
$

也就是说，覆盖状态感知机制主要增加的是种群层面的状态判断和参数裁剪，真正耗时的部分仍是候选解动态仿真评估。算法因此获得了面向覆盖路由的搜索引导，而主阶复杂度没有随之上升。
== 章节小结

本章在第 3 章模型的基础上设计覆盖状态感知 L-SHADE 路由优化算法。算法首先沿用 L-SHADE 的基本求解流程，并结合本文的控制序列优化问题说明编码、解码、仿真评估和个体选择方式。原始 L-SHADE 的短板主要出现在覆盖反馈上：随机初始化容易产生低覆盖初始解，参数自适应过程也不知道当前覆盖结构是否已经稳定，搜索方向因此可能过早偏向局部性能细化。

针对这一问题，本章加入两项改进。覆盖优先初始化根据任务节点空间分布生成覆盖导向个体，让初始种群更接近可服务区域；覆盖状态感知参数控制则作用于迭代过程，根据覆盖率、覆盖缺口和覆盖变化趋势判断搜索状态，再调整 $p$、$F$ 和 $"CR"$。覆盖构造、覆盖保持、性能精修和覆盖恢复对应不同的参数约束，算法由此能在不同阶段采取不同搜索尺度。复杂度分析表明，这些新增步骤主要带来初始化和种群覆盖统计开销，真正耗时的部分仍是候选解动态仿真评估。也就是说，算法没有改写 L-SHADE 的主体框架，而是在其外层补上了与覆盖路由任务更贴近的状态引导。

= 仿真实验与结果分析

本章用仿真实验检验覆盖状态感知 L-SHADE 在异构无人机集群动态路由规划中的表现。实验在统一固定环境下比较原始 L-SHADE、覆盖优先初始化 L-SHADE 和覆盖状态感知 L-SHADE，并观察综合目标、覆盖性能、覆盖违约、连通违约、吞吐量、队列负载、能耗以及收敛过程的变化。这里关心的不只是最终数值谁更优，还包括覆盖状态感知机制是否真的改变了搜索后期的行为。

== 实验设置

为评估覆盖状态感知 L-SHADE 算法在异构无人机集群动态路由规划问题中的表现，本文在统一仿真平台下开展对比实验。所有实验均基于第 3 章建立的无人机运动、通信、覆盖、队列与能量模型实现，并采用固定环境设置，以保证不同算法之间的比较条件一致。

固定环境实验只改变算法，不改变场景。任务节点分布、UAV 初始位置和异构参数在三种算法之间保持一致，随机种子取 42。每种算法独立运行 5 次，最大函数评估次数为 30000。场景规模为 $N = 8$、$K = 20$；仿真时长 $T = 200$，$Delta t = 1 "s"$。控制段长度取 10 个时隙，因此共有 20 个控制段；飞行高度固定为 $H = 100 "m"$。

为体现无人机异构性，实验中各 UAV 的覆盖半径、最大速度、带宽、最大发射功率、队列容量及初始能量均采用随机异构配置，其参数范围如表 5-1 所示。

#align(center)[表 5-1 异构 UAV 参数取值范围]

#three-line-table(
  columns: (1fr, auto),
  table.header([参数], [取值范围]),
  [最大速度 $V_i^"max"$], [[10, 25] m/s],
  [覆盖半径 $R_i^c$], [[150, 300] m],
  [带宽 $B_i$], [[1e6, 5e6] Hz],
  [最大发射功率 $P_i^"max"$], [[1, 5] W],
  [队列容量 $Q_i^"max"$], [[5e6, 1e7] bit],
  [初始能量 $E_i^"max"$], [[2e5, 3e5] J],
)

其余通信模型参数、动力学约束参数以及覆盖状态感知 L-SHADE 状态控制参数见附录 B。
== 对比算法与评价指标
在算法选型阶段，本文曾对 GA、PSO 和基础 DE 等常见元启发式算法进行前期筛选，用于比较不同类型优化方法在 UAV 高维连续控制序列问题中的适用性。GA 具有较强的全局搜索能力，但在本文分段控制向量维度较高、变量强耦合的场景下，收敛效率相对较低，结果波动较明显；PSO 在连续变量优化中实现简单、早期搜索速度较快，但容易出现早熟收敛，在覆盖结构尚未稳定时可能过早集中到局部解区域；基础 DE 能够较好适配速度、航向角和发射功率等实数编码变量，但其参数控制和种群规模策略较为基础，面对覆盖阈值非光滑、队列动态演化和多指标耦合目标时，稳定性和后期开发能力不足。综合前期筛选结果，L-SHADE 在高维连续优化、参数自适应和搜索收敛性方面更适合作为本文问题的基础框架。因此，后续算法设计围绕 L-SHADE 展开。本章正式实验比较原始 L-SHADE、覆盖优先初始化 L-SHADE 和覆盖状态感知 L-SHADE 三种算法。三种算法采用统一的差分进化框架与基础参数配置，其初始种群规模为 100，最小种群规模为 20，历史记忆长度为 10，最大函数评估次数为 30000。

实验结果采用固定环境下 5 次独立运行的统计结果，并以均值和标准差形式展示。评价指标沿用第 3 章定义的综合性能指标。主结果关注三种算法在 $J_"total"$、coverage ratio、$V_"cov"^"norm"$ 和 $V_"con"^"norm"$ 上的差异；辅助分析结合 $R_"norm"$、$Q_"norm"$ 和 $E_"norm"$，解释不同算法在吞吐、队列和能耗方面的变化。

本文不单独进行显著性检验，而是结合均值、标准差、收敛过程以及不同任务节点规模下的性能变化趋势分析算法结果。
== 实验结果与分析

本节基于固定环境下 5 次独立运行结果比较三种算法。分析对象包括综合目标值、覆盖性能、吞吐量、队列负载和能耗，并结合收敛曲线及不同任务节点规模下的折线结果观察算法变化。除实验参数说明外，本节主要使用图像展示结果，不再额外加入箱线图和大幅结果表格。

=== 收敛性能分析

图 5-1 给出了三种算法在固定环境下的 best $J_"total"$ 随函数评价次数 NFE 的变化情况。三条曲线在优化初期都下降较快，表明 L-SHADE 系列方法能够先从随机初始解附近跳到较可用的控制区域；差异主要出现在中后期，此时算法是否还能继续修正覆盖与回传结构，会直接影响最终目标值。

#capfig(
  image("figures/image5-4.png", width: 80%),
  caption: [三种算法 best $J_"total"$-NFE 收敛曲线],
  label: <fig:best-j-total-nfe>,
)

原始 L-SHADE 在初期下降后较早进入平台期，约在 5000 次 NFE 后目标值变化趋于平缓，最终仅收敛至接近 $-0.02$ 的水平。这个现象和本文问题本身有关：候选解同时牵动 UAV 运动控制、覆盖关系、通信速率、队列演化和能量消耗，目标面很难是一个平滑、单一方向的搜索空间。原始 L-SHADE 没有使用覆盖结构和网络状态信息，前期还能依靠通用差分扰动找到可行区域；进入后期后，种群缺少继续修正覆盖与回传结构的线索，因而容易停在局部区域。

覆盖优先初始化 L-SHADE 在优化初期取得了更低的目标函数值，多数迭代阶段也优于原始 L-SHADE。覆盖优先初始化的作用比较直接：它把一部分初始个体放到更接近任务节点分布的位置，减少了从随机轨迹中摸索覆盖结构的成本。不过，这一改动主要影响搜索入口。迭代进入中后期以后，如果算法不再感知覆盖状态，前期形成的覆盖结构仍可能在差分扰动中被削弱。

覆盖状态感知 L-SHADE 前期并不总是压过覆盖优先初始化 L-SHADE，但中后期仍能继续下降，并最终取得最低的 $J_"total"$。它的优势不是起步快，而是后续搜索没有过早失去方向。覆盖状态感知机制让种群在覆盖保持、吞吐提高和资源消耗控制之间反复调整，最终解质量因此更好。这里也要留一点余地：覆盖状态感知 L-SHADE 后期阴影区间相对较宽，不同独立运行之间仍有波动，所以本文只把它表述为最终综合性能更好、后期搜索能力更强，而不说它在全过程中都最稳定。

=== 覆盖性能分析

图 5-2 展示了三种算法在固定环境下的最终覆盖率和覆盖违约度。覆盖率反映任务节点被 UAV 服务的比例，覆盖违约度 $V_"cov"^"norm"$ 则从反方向刻画未覆盖任务节点的累计程度。

#capfig(
  image("figures/image覆盖性能.png", width: 90%),
  caption: [固定环境下三种算法覆盖性能对比],
  label: <fig:fixed-coverage-performance>,
)

从最终覆盖率看，原始 L-SHADE 的覆盖率为 $0.8274$，覆盖优先初始化 L-SHADE 提升至 $0.8596$，覆盖状态感知 L-SHADE 达到 $0.8943$。换算后，覆盖状态感知 L-SHADE 相较原始 L-SHADE 多出 $0.0669$，即 6.69 个百分点；相较覆盖优先初始化 L-SHADE 也多出 $0.0347$，即 3.47 个百分点。这个差距大致来自两层影响：覆盖优先初始化先把种群起点拉近任务节点区域，覆盖状态感知参数控制机制再减少后续搜索中覆盖结构被打散的概率。

从覆盖违约度看，原始 L-SHADE 的 $V_"cov"^"norm"$ 为 $0.1726$，覆盖优先初始化 L-SHADE 降至 $0.1505$，覆盖状态感知 L-SHADE 降至 $0.1076$。与原始 L-SHADE 相比，覆盖状态感知 L-SHADE 将覆盖违约度降低约 37.7%；与覆盖优先初始化 L-SHADE 相比，降低约 28.5%。覆盖违约度比单纯覆盖率更能反映任务周期内的服务缺口。也就是说，覆盖状态感知 L-SHADE 不只是让更多节点被覆盖过，还减少了一些节点长期处在服务范围外的情况。

这一组结果也提醒我们，动态覆盖问题很敏感。UAV 的小幅位置变化，可能就会让某个任务节点从可覆盖变成不可覆盖；如果搜索方向不受覆盖状态约束，已经形成的服务结构很容易被后续扰动打散。覆盖状态感知 L-SHADE 的改动正好作用在这里：它让变异和选择更愿意保留覆盖结构较好的个体。固定环境下三种算法的功能性连通违约均接近 0，因此本组实验的主要差异落在覆盖能力、吞吐表现、队列负载和能耗水平上。

=== 通信性能与资源消耗分析

图 5-3 从吞吐量、队列负载和能耗三个角度比较最终结果。$R_"norm"$ 反映任务周期内进入 Sink 的归一化数据量，数值越高越好；$Q_"norm"$ 描述缓存积压，越低说明队列压力越小；$E_"norm"$ 对应系统能耗，也以较低为优。

#capfig(
  image("figures/image通信性能与资源消耗.png", width: 95%),
  caption: [固定环境下三种算法通信性能与资源消耗对比],
  label: <fig:fixed-component-performance>,
)

吞吐量结果中，原始 L-SHADE 的 $R_"norm"$ 为 $0.2826$，覆盖优先初始化 L-SHADE 为 $0.4368$，覆盖状态感知 L-SHADE 为 $0.4641$。相较原始 L-SHADE，覆盖状态感知 L-SHADE 的提升约为 64.2%。这个差距不应简单归因于发射功率变大，因为能耗并没有同步升高。更合理的解释是，覆盖结构稳定后，任务数据能更持续地进入 UAV 队列；同时部分 UAV 的位置更利于回传，Sink 侧接收到的数据随之增加。

在队列负载方面，原始 L-SHADE 的 $Q_"norm"$ 为 $0.3533$，覆盖优先初始化 L-SHADE 降至 $0.2918$，覆盖状态感知 L-SHADE 降至 $0.2839$。相较原始 L-SHADE，覆盖状态感知 L-SHADE 降低约 19.6%。不过，这一指标上的差距不如覆盖率和吞吐量明显，覆盖状态感知 L-SHADE 与覆盖优先初始化 L-SHADE 的误差区间也有重叠。笔者倾向于把它看作一种伴随变化：覆盖和回传结构变好后，队列积压有所缓解，但队列本身仍受 Sink 回传能力和任务数据到达量制约。

在能耗方面，原始 L-SHADE 的 $E_"norm"$ 为 $0.000416$，覆盖优先初始化 L-SHADE 为 $0.000407$，覆盖状态感知 L-SHADE 降至 $0.000391$。三者绝对差异不大，但方向一致：覆盖状态感知 L-SHADE 在覆盖率和吞吐量更高的同时，没有付出更高能耗。这个结果对本文问题比较关键。若性能变化主要来自过度移动或盲目提高功率，能耗指标通常会同步上升；当前数值更像是轨迹、覆盖关系和通信结构被重新协调后的结果。

把五个指标放在一起看，覆盖状态感知 L-SHADE 在固定环境下形成了一个较稳的折中：覆盖率和吞吐量提高，覆盖违约度、队列负载和能耗降低。尤其是吞吐量增加而能耗没有上升，这一点排除了“靠额外能耗换吞吐”的简单解释，更像是覆盖关系和回传结构被重新协调后的结果。

=== 不同任务节点规模下的性能分析

地面任务节点数量变化时，覆盖压力和数据到达量都会改变。为观察这种负载变化带来的影响，本节调整任务节点规模，并比较三种算法的覆盖率、能耗、队列负载和吞吐量。这里重点看趋势变化，所以使用三种算法的对比折线图，不再展开覆盖状态感知 L-SHADE 的参数敏感性。

#capfig(
  image("figures/coverage.png", width: 80%),
  caption: [不同任务节点数量下三种算法覆盖率变化],
  label: <fig:coverage-task-node-count>,
)

从图 5-4 观察，三种算法的覆盖率没有随任务节点数量增加而单调变化。这并不意外。任务节点数量只是影响覆盖难度的因素之一，节点空间分布、UAV 覆盖半径、通信半径以及 Sink 位置都会改变实际服务结构。在多数任务节点规模下，覆盖状态感知 L-SHADE 的覆盖率更高；任务节点数量较多时，这种优势仍能维持。相比之下，覆盖优先初始化 L-SHADE 在中等规模场景下表现尚可，但在部分高任务节点数场景中覆盖率下降较明显。只改善初始化还不够，后续搜索仍需要处理覆盖退化问题。

#capfig(
  image("figures/energy.png", width: 80%),
  caption: [不同任务节点数量下三种算法能耗变化],
  label: <fig:energy-task-node-count>,
)

图 5-5 中，原始 L-SHADE 在多数场景下能耗更高，波动也更明显。缺少任务结构引导时，种群可能通过额外移动或低效通信弥补覆盖和回传不足。覆盖优先初始化 L-SHADE 与覆盖状态感知 L-SHADE 的能耗整体较低，说明覆盖导向信息减少了一部分无效搜索。需要补充的是，覆盖状态感知 L-SHADE 并非每个任务规模下都最低能耗；它的优势更适合结合覆盖率和吞吐量一起判断。

#capfig(
  image("figures/queue.png", width: 80%),
  caption: [不同任务节点数量下三种算法队列负载变化],
  label: <fig:queue-task-node-count>,
)

图 5-6 反映出队列指标对任务节点规模更敏感。当任务节点数量增加后，系统数据到达量随之增加；如果 Sink 回传能力或中继链路能力没有同步跟上，UAV 缓存队列就会积压。实验中有一个现象需要单独看：部分任务规模下覆盖率和吞吐量较高，但队列负载也同步升高。由此可以判断，高覆盖率并不自动等于低队列压力。覆盖范围扩大后，系统采集的数据更多；若回传链路没有同步改善，队列反而会承受更大压力。因此，动态路由规划不能只追求覆盖率，还必须把吞吐量和队列稳定性放在同一框架中讨论。

#capfig(
  image("figures/throughput.png", width: 80%),
  caption: [不同任务节点数量下三种算法吞吐量变化],
  label: <fig:throughput-task-node-count>,
)

从图 5-7 来看，覆盖状态感知 L-SHADE 在中高任务节点规模下的吞吐水平更高。原因不只是服务范围扩大，还包括回传结构的调整。覆盖状态感知机制帮助算法保留较好的覆盖个体，同时也让搜索过程继续寻找更有利于 Sink 汇聚的数据转发结构。原始 L-SHADE 在多数规模下吞吐量较低；缺少问题结构引导时，通用差分搜索很难充分利用 UAV 的通信资源。

任务节点规模实验给出的结论并不是“节点越多算法越强”，而是：负载变化以后，覆盖状态感知 L-SHADE 更不容易丢失覆盖结构，并且在高负载场景下仍能维持相对较好的吞吐能力。与此同时，队列负载结果也提醒本文模型还有改进空间。若 Sink 回传瓶颈长期存在，仅靠覆盖状态感知还不足以完全压低队列积压。后续可以把队列状态和链路拥塞信息更直接地纳入搜索引导，用来检验算法在长任务周期下的稳定性。

=== 综合讨论

固定环境实验和任务节点规模实验放在一起看，原始 L-SHADE 的短板比较清楚。它在优化初期能够降低目标函数值，但很快进入平台期；覆盖率、吞吐量、队列负载和能耗等指标也都不占优。问题不在于 L-SHADE 不能处理连续变量，而在于本文问题的结构信息太强：UAV 位置、覆盖关系、链路速率和队列状态之间相互牵连，单靠通用差分扰动很难持续修正这些关系。

覆盖优先初始化 L-SHADE 的改动解决了搜索入口问题。覆盖优先初始化把部分初始个体引向任务节点分布区域，使算法在初期就能形成较好的覆盖结构。它相较原始 L-SHADE 的变化是明显的，尤其体现在收敛初期和覆盖性能上。不过，初始化只能决定起点，不能保证后续差分变异始终保护已有覆盖结构。随着迭代推进，覆盖优先初始化 L-SHADE 仍可能破坏前期形成的有效轨迹，因此最终性能存在上限。

覆盖状态感知 L-SHADE 的变化发生在迭代过程中。固定环境实验里，它的最终覆盖率为 $0.8943$，覆盖违约度为 $0.1076$，吞吐量达到 $0.4641$，队列负载和能耗分别为 $0.2839$ 与 $0.000391$。单看任意一个指标，都不足以说明机制是否有效；把它们合在一起看，更接近本文想验证的问题：覆盖结构被保留下来以后，回传能力和队列状态是否也能随之改善。结果显示，吞吐量提高并没有伴随能耗增加，因此该改进更像是调整了轨迹、覆盖与回传关系，而不是简单用更多资源换取性能。

覆盖状态感知 L-SHADE 的结果也需要留出边界。从标准差和收敛曲线阴影范围看，部分指标仍然有波动，尤其是吞吐量和后期目标函数值。覆盖状态感知提高了搜索上限，但随机种子和场景结构的影响并没有消失。后续实验至少应增加独立运行次数，并在更多任务节点分布、UAV 规模和数据产生强度下重复验证。

因此，本章实验更适合得出一个有限结论：在当前固定环境和任务节点规模变化实验中，覆盖状态感知 L-SHADE 比原始 L-SHADE 和覆盖优先初始化 L-SHADE 更能维持覆盖结构，并能把覆盖变化转化为较高吞吐量。至于更复杂通信环境下是否仍然成立，还需要引入更真实的信道、队列和显式路由机制继续验证。

= 总结与展望

== 主要研究成果与创新点

本文讨论的异构 UAV 集群动态路由规划，并不是传统意义上的下一跳选择，而是 UAV 控制序列优化。轨迹、覆盖、链路、队列和能耗在这里相互牵连：某一控制段的速度、航向角和发射功率，会通过 UAV 位置和链路状态继续影响后续时隙。围绕这一认识，本文完成了以下工作。

首先，本文建立了面向异构 UAV 集群的动态覆盖路由规划模型。与只考虑静态覆盖或拓扑连通的模型不同，本文把 UAV 运动控制、地面任务节点覆盖、链路传输速率、缓存队列演化和能量消耗放入同一框架，用来描述“轨迹-覆盖-队列-回传-能耗”之间的动态耦合关系。其中，功能性回传能力用于刻画系统面向 Sink 的数据泄放能力，避免仅凭静态图论连通性判断网络性能。对于灾后应急通信场景来说，路径是否存在并不够，数据能否持续传回 Sink 才是更直接的问题。

在评价指标设计上，本文将归一化吞吐量、队列负载、能耗、覆盖违约和连通性违约纳入综合目标函数。吞吐量用于反映 Sink 侧数据汇聚能力，队列负载和能耗则约束通信与运动代价，覆盖违约和连通性违约负责限制服务失效风险。加权目标函数之外，本文还加入覆盖与回传优先的层级判优逻辑。这样处理的原因很直接：如果覆盖和回传能力尚未形成，过早比较吞吐量或能耗容易把算法引向局部可行但服务不足的区域。

针对原始 L-SHADE 随机初始化缺少任务节点空间信息的问题，本文设计了覆盖优先初始化机制。该机制根据地面任务节点分布生成一部分覆盖导向初始个体，通过目标点选择、UAV-目标匹配和“接近-保持”式控制序列生成，让初始种群中包含更接近覆盖可行区域的方案。实验中，覆盖优先初始化 L-SHADE 相较原始 L-SHADE 在收敛初期和最终覆盖性能上均有所改善，说明覆盖结构信息确实能为差分进化搜索提供更合适的入口。

仅改善入口仍然不够。原始 L-SHADE 的参数自适应主要依赖历史成功经验，却不知道当前种群覆盖状态是否已经稳定。为此，本文提出覆盖状态感知 L-SHADE 算法，构造覆盖状态指标和有限状态机，将搜索过程区分为覆盖构造、覆盖稳定、性能精修和覆盖恢复四类状态，并据此约束 $p$、$F$ 和 $"CR"$。这一机制使 L-SHADE 在保持连续搜索框架的同时，能够根据覆盖状态调整搜索尺度和方向，减少已有覆盖结构在后续迭代中被破坏的情况。

实验部分比较了原始 L-SHADE、覆盖优先初始化 L-SHADE 和覆盖状态感知 L-SHADE，并进一步改变任务节点数量观察趋势。固定环境中，覆盖状态感知 L-SHADE 的覆盖率为 $0.8943$，覆盖违约度为 $0.1076$，吞吐量为 $0.4641$，队列负载和能耗分别为 $0.2839$、$0.000391$。收敛曲线更值得注意的是中后期差异：覆盖状态感知 L-SHADE 并非只依赖更好的初始下降，而是在覆盖结构形成后仍能继续修正控制序列。任务节点规模实验也显示，它在多数规模下保持了较高覆盖率，并在中高负载场景下维持较好的吞吐水平。

== 不足与展望

本文模型和实验仍有简化。这样做便于单独观察覆盖状态感知机制，但结论外推时需要谨慎。后续工作可从以下方向展开。

通信信道模型还比较简化。当前模型采用二维距离平方衰减，没有显式加入三维距离、高度变化、地形遮挡、LoS/NLoS 概率切换、多径衰落和同频干扰。灾后场景中，建筑物遮挡、地形起伏和临时干扰源都可能改变链路速率；换成更真实的空地信道后，覆盖状态感知 L-SHADE 对覆盖与回传结构的调节能力还需要重新检验。

路由表征仍停留在规划层面的功能性回传建模。本文通过 UAV-UAV 链路速率、UAV-Sink 汇聚速率和队列泄放能力描述动态回传能力，但没有设置显式下一跳选择、链路调度或数据包级路由变量。也就是说，本文讨论的是控制序列层面的动态路由规划，而不是完整协议层路由。后续可以把图路由或流量分配模型纳入同一优化框架，考察 UAV 轨迹控制与显式路由决策之间的耦合关系。

实验验证还需要加厚。本文已经在固定环境和不同任务节点规模下比较了三种算法，但独立运行次数较少，也没有单独进行显著性检验。从收敛曲线阴影范围和部分指标标准差看，覆盖状态感知 L-SHADE 仍受随机种子和场景结构影响，尤其在吞吐量和后期目标函数值上波动更明显。后续应增加独立运行次数，并在多随机任务分布、多 UAV 规模和不同数据产生强度下重复实验，再判断当前结论是否稳定。

队列与回传瓶颈也需要单独处理。任务节点规模实验已经显示，高覆盖率并不必然带来低队列负载。覆盖范围扩大后，进入 UAV 队列的数据量会增加；如果 Sink 回传能力或 UAV 间转发能力没有同步跟上，系统仍可能出现积压。后续可以把队列状态反馈、链路拥塞感知或回传优先调度加入搜索过程，观察算法能否在提高覆盖和吞吐的同时降低长期队列压力。

另外，覆盖状态感知 L-SHADE 的状态控制参数仍依赖人工设定。本文根据覆盖状态设计了参数约束范围，但不同任务规模、UAV 异构程度和数据到达强度下，合适阈值可能并不相同。后续可以尝试自适应阈值调整、强化学习辅助参数控制或多状态记忆机制，使算法在不同环境中自动修正状态判定条件和参数范围。

在当前仿真设置下，覆盖状态感知 L-SHADE 改善了覆盖保持和综合优化表现，但这一结论还不能直接推广到所有应急通信场景。后续需要进一步检验更真实的通信环境、显式路由机制、统计显著性、队列感知搜索引导以及自适应参数控制。

